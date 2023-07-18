require 'rails_helper'

RSpec.describe '/', type: :feature do
  before(:each) do
    @user1 = User.create!(name: "Sarah", email: "Sarah@gmail.com", password: 'test', password_confirmation: 'test')
    @user2 = User.create!(name: "Jimmy", email: "Jimmy@gmail.com", password: 'test', password_confirmation: 'test')
    @user3 = User.create!(name: "Alex", email: "Alex@gmail.com", password: 'test', password_confirmation: 'test')
    @user4 = User.create!(name: "John", email: "John@gmail.com", password: 'test', password_confirmation: 'test')
    visit root_path
  end
  describe "User visits root path" do
    it "should display title of application" do
      expect(page).to have_content("Viewing Party")
    end

    it "should display button to create a new user" do
      expect(page).to have_button("Create New User")
    end

    it "should display existing users with links to the users dashboard" do
      within("#existing-users") do
        expect(page).to have_content("#{@user1.name}")
        expect(page).to have_content("#{@user2.name}")
        expect(page).to have_content("#{@user3.name}")
        expect(page).to have_content("#{@user4.name}")
      end
    end

    it "should have a nav home page link" do
      expect(page).to have_link("Home")
    end
  end
end