class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new

  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      flash[:error] = "Email Address Must Be Unique"
      render :new
    end
  end

  private 
  def user_params
    params.permit(:name, :email)
  end
end