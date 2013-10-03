class Admin::BadgesController < Admin::AdminController
  before_filter :set_badge, only: [:show, :edit, :update, :destroy]

  def index
    @badges = Badge.all
  end

  def show
  end

  def new
    @badge = Badge.new
  end

  def edit
  end

  def create
    @badge = Badge.new(params[:badge])

    if @badge.save
      redirect_to [:admin, @badge], 
        notice: "Badge was successfully created.<br />
          Define badge conditions in <strong>#{Rails.application.class.parent_name}/app/models/concerns/ff_badges/#{@badge.filename}.rb</strong><br />
          and activate it in <strong>#{Rails.application.class.parent_name}/app/models/user.rb</strong>.".html_safe
    else
      render action: 'new'
    end
  end

  def update
    if @badge.update_attributes(params[:badge])
      redirect_to [:admin, @badge], 
        notice: "Badge was successfully updated.<br />
          Define badge conditions in <strong>#{Rails.application.class.parent_name}/app/models/concerns/ff_badges/#{@badge.filename}.rb</strong>.".html_safe
    else
      render action: 'edit'
    end
  end

  def destroy
    @badge.destroy
    redirect_to admin_badges_url, notice: "Badge was successfully destroyed.<br />
      Deactivate it in <strong>#{Rails.application.class.parent_name}/app/models/user.rb</strong>.".html_safe
  end

  private

    def set_badge
      @badge = Badge.find(params[:id])
    end

    # def badge_params
    #   params.require(:badge).permit(:name, :description, :message, :filename, :points, :icon)
    # end
end
