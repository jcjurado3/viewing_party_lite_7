require 'rails_helper'

RSpec.describe 'Movie Details Page', type: :feature do
  before(:each) do
    @user1 = User.create!(name: 'Sarah', email: 'sarah@gmail.com', password: 'test', password_confirmation: 'test')
    movies = SearchFacade.new.movies
    @movie = movies.first
    @reviews = MovieFacade.new(@movie.id).get_reviews

    visit movie_show_path(@user1.id, @movie.id)
  end
  describe 'As a user, when I visit the Movie Details Page' do
    it 'displays button to create a viewing party and button to return to discover page', :vcr do
      expect(page).to have_button('Create Viewing Party')
      expect(page).to have_button('Discover Page')
    end

    it 'Discover Page button takes user back to Discover Page', :vcr do
      click_button('Discover Page')

      expect(current_path).to eq(discover_path(@user1))
    end

    it 'Create Viewing Party button takes user to create page', :vcr do
      click_button('Create Viewing Party')

      expect(current_path).to eq(new_viewing_party_path(@user1, @movie.id))
    end

    it 'displays movie details', :vcr do
      expect(page).to have_content(@movie.title)
      expect(page).to have_content(@movie.vote_average)
      expect(page).to have_content(@movie.genres)
      expect(page).to have_content(@movie.runtime)
      expect(page).to have_content(@movie.summary)
    end

    it 'displays move cast members', :vcr do
      expect(page).to have_css('.cast_name', count: 10)
      expect(page).to have_css('.cast_character', count: 10)
    end
    
    it 'display total reviews with author and information', :vcr do
      expect(page).to have_content("Number of Reviews: #{@reviews.count}")
      expect(page).to have_css('.review_author')
      expect(page).to have_css('.review_content')
    end
  end
end