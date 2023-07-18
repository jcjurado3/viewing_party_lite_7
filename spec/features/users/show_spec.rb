require 'rails_helper'

RSpec.describe 'Users Show Page', type: :feature do
  before(:each) do
    @user1 = User.create!(name: 'Sarah', email: 'Sarah@gmail.com', password: 'test', password_confirmation: 'test')
    @user2 = User.create!(name: 'Jimmy', email: 'Jimmy@gmail.com', password: 'test', password_confirmation: 'test')

    visit user_path(@user1)
  end

  describe 'As a visitor, when I visit a user show page' do
    it 'displays the user name at the top of the page' do
      expect(page).to have_content("#{@user1.name}'s Dashboard")

      expect(page).to_not have_content("#{@user2.name}'s Dashboard")
    end

    it 'displays a button to Discover Movies and redirects to that page' do
      expect(page).to have_button('Discover Movies')
    end

    it 'displays a section that lists viewing parties' do
      expect(page).to have_content('Viewing Parties')
    end
  end
end
