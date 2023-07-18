require 'rails_helper'

RSpec.describe 'Movies Index Page', type: :feature do
  before(:each) do
    @user1 = User.create!(name: 'Sarah', email: 'sarah@gmail.com', password: 'test', password_confirmation: 'test')
    @user2 = User.create!(name: 'Jimmy', email: 'jimmy@gmail.com', password: 'test', password_confirmation: 'test')
  end
  describe 'As a user, when I visit the Discover Movies page and I click on Top Movies or Search button' do
    it 'displays the title with link and vote average for the top 20 movies', :vcr do
        visit discover_path(@user1)
  
        fill_in :search, with: 'Batman'
        click_button 'Search'

        expect(current_path).to eq(movies_path(@user1))
        expect(page.status_code).to eq(200)
        expect(page).to have_content('Batman')

        expect(page).to have_link('Batman')

        expect(page).to have_css('.movie', count: 20)
        expect(page).to_not have_css('.movie', count: 21)
    end

    it 'has a button to return to the Discover Page', :vcr do
      visit movies_path(@user1)

      expect(page).to have_button('Discover Page')

      click_on('Discover Page')

      expect(current_path).to eq(discover_path(@user1))
    end

    it 'Top Movies Button is clicked and taken to the movies results page', :vcr do
      visit discover_path(@user1)

      click_button('Discover Top Rated Movies')

      expect(current_path).to eq(movies_path(@user1))
      expect(page).to have_content('The Godfather')
    end
  end
end

