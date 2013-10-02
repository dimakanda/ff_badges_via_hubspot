class Admin::AdminController < ApplicationController
  layout 'admin'

  before_filter :require_login, :verify_admin

  private

  def verify_admin
    redirect_to(root_path, alert: 'Sorry, only administrators can access this page.') unless current_user.admin?
  end

end