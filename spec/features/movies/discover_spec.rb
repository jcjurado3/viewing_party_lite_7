require 'rails_helper'

RSpec.describe 'Users Discover Page', type: :feature do
  before(:each) do
    @user1 = User.create!(name: 'Sarah', email: 'Sarah@gmail.com', password: 'test', password_confirmation: 'test')
    @user2 = User.create!(name: 'Jimmy', email: 'Jimmy@gmail.com', password: 'test', password_confirmation: 'test')
  end
  describe 'As a user, when I visit the User Dashboard and I click on "Discover Movies"' do
    it 'redirects me to a discover movies page' do
      visit user_path(@user1)
      click_button 'Discover Movies'

      expect(current_path).to eq(discover_path(@user1))

      visit user_path(@user2)
      click_button 'Discover Movies'

      expect(current_path).to eq(discover_path(@user2))
    end
  end

  describe 'As a user, when I visit the User Discover Page' do
    it 'displays button to Discover Top Rated Movies' do
      visit discover_path(@user1)
      expect(page).to have_button("Discover Top Rated Movies")
    end

    it 'display a search by movie title text field with search button' do
      visit discover_path(@user1)
      expect(page).to have_field("Search by Movie Title")
      expect(page).to have_button("Search")
    end

    it 'redirect to movies result page after clicking Discover Top Rated Movies or search button', :vcr do
      visit discover_path(@user1)

      click_button("Discover Top Rated Movies")

      expect(current_path).to eq(movies_path(@user1))

      visit discover_path(@user1)

      fill_in :search, with: 'Batman Forever'
      click_button "Search"

      expect(current_path).to eq(search_path(@user1))
    end
  end
end