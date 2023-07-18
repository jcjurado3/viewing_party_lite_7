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

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
    redirect_to user_path(user.id)
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :new
    end
    
  end

  private  
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end