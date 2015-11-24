class SessionController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_username(params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:success] = "#{@user.username} has logged in"
      if current_admin?
        redirect_to admin_dashboard_index_path
      else
        redirect_to dashboard_path
      end
    else
      flash.now[:error] = "Invalid Credentials. Try again."
      render :new
    end
  end

  def destroy
    session.destroy
    redirect_to '/'
  end
end
