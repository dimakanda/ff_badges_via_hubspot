class Admin::BadgesController < Admin::AdminController
  before_filter :set_badge, only: [:show, :edit, :update, :destroy]

  def index
    @badges = Badge.all
    @activated_badges = User.activated_badges
    @not_configured_badges = @activated_badges - @badges.collect(&:filename).map(&:to_sym)
  end

  def new
    @badge = Badge.new
  end

  def edit
  end

  def create
    @badge = Badge.new safe_params

    if @badge.save
      redirect_to [:admin, :badges],
        notice: "Badge was successfully created.<br />
          Define badge conditions in <strong>/extras/ff_badges/badges/#{@badge.filename}.rb</strong><br />
          and activate it in <strong>/app/models/user.rb</strong>.".html_safe
    else
      render action: 'new'
    end
  end

  def update
    if @badge.update(safe_params)
      redirect_to [:admin, :badges],
        notice: "Badge was successfully updated.<br />
          Define badge conditions in <strong>/extras/ff_badges/badges/#{@badge.filename}.rb</strong>.".html_safe
    else
      render action: 'edit'
    end
  end

  def destroy
    @badge.destroy
    redirect_to admin_badges_url, notice: "Badge was successfully destroyed.<br />
      Deactivate it in <strong>/app/models/user.rb</strong>.".html_safe
  end

  private

    def set_badge
      @badge = Badge.find(params[:id])
    end

    def safe_params
      params.require(:badge).permit(:name, :external_earned_description, :external_unearned_description, :internal_description, :message, :filename, :points, :icon, :icon_inactive, :invertable, :secret)
    end
end
