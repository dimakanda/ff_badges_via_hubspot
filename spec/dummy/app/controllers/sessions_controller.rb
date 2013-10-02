class SessionsController < ApplicationController

  def create
    user = login params[:email], params[:password], params[:remember_me]
    if user
      url = user.admin? ? "/admin" : root_path
      redirect_back_or_to url, notice: "Hi. You have been logged in."
    else
      flash.now.alert = "Oops. The email or password you entered is invalid."
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, notice: "Bye. You have been logged out."
  end

end