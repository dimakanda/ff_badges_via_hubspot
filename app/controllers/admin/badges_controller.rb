class Admin::BadgesController < Admin::AdminController
  before_action :set_badge, only: [:show, :edit, :update, :destroy]

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
    @badge = Badge.new(badge_params)

    if @badge.save
      redirect_to [:admin, @badge], 
        notice: "Badge was successfully created. 
          Define badge conditions in #{Rails.application.class.parent_name}/app/models/concerns/ff_badges/#{@badge.filename}.rb 
          and activate it in #{Rails.application.class.parent_name}/app/models/user.rb."
    else
      render action: 'new'
    end
  end

  def update
    if @badge.update(badge_params)
      redirect_to [:admin, @badge], 
        notice: "Badge was successfully updated. 
          Define badge conditions in #{Rails.application.class.parent_name}/app/models/concerns/ff_badges/#{@badge.filename}.rb."
    else
      render action: 'edit'
    end
  end

  def destroy
    @badge.destroy
    redirect_to admin_badges_url, notice: "Badge was successfully destroyed. 
      Deactivate it in #{Rails.application.class.parent_name}/app/models/user.rb"
  end

  private

    def set_badge
      @badge = Badge.find(params[:id])
    end

    def badge_params
      params.require(:badge).permit(:name, :description, :message, :filename, :points, :icon)
    end
end
