class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.new(user)
    session[:user_id] = new_user.id
    if new_user.save && new_user.authenticate(params[:password]) == new_user.authenticate(params[:password_confirmation])
      flash[:success] = "Welcome, #{new_user.name}!"
      redirect_to user_path(new_user.id)
    else
      flash[:error] = "Invalid Credentials, Please Try Again"
      render :new
    end
  end

  private  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end