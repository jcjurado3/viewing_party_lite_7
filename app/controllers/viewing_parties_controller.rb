class ViewingPartiesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @users = User.all

    @movie = MovieFacade.new(params[:movie_id]).get_movie_details
  end

  def create 
    user = User.find(params[:user_id])
    movie = MovieFacade.new(params[:movie_id]).get_movie_details
    party = Party.create!(viewing_party_params)
    
    UserParty.create!(user_id: user.id, party_id: party.id)

    redirect_to user_path(user.id)
  end 

  private
  def viewing_party_params
    params.permit(:duration, :date, :time, :movie_id)
  end
end