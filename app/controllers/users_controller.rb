class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
 
    # movie_id = @user.parties.first.movie_id
    # @movie = SearchFacade.new(params[movie_id]).movies.first
    # @party = @user.parties.first
  end

  def new
    @user = User.new
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
    params.require(:user).permit(:name, :email)
  end
end