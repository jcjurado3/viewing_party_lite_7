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
      click_on "Log In"

        fill_in :email, with: "Jimmy@gmail.com"
        fill_in :password, with: "test"
        click_on "Submit"

      visit root_path

      within("#existing-users") do
        expect(page).to have_content("#{@user1.email}")
        expect(page).to have_content("#{@user2.email}")
        expect(page).to have_content("#{@user3.email}")
        expect(page).to have_content("#{@user4.email}")
      end
    end

    it "should have a nav home page link" do
      expect(page).to have_link("Home")
    end
  end

  describe "/ - root page" do
    context "happy path" do
      it "log in link" do
        visit root_path

        expect(page).to have_button("Log In")
        click_button "Log In"

        expect(current_path).to eq(new_session_path)
      end
      it "has login form" do
        visit root_path
        click_on "Log In"

        fill_in :email, with: "Jimmy@gmail.com"
        fill_in :password, with: "test"
        click_on "Submit"

        expect(current_path).to eq(user_path(@user2))
      end
      it 'log out link' do
        visit root_path
        click_on "Log In"

        fill_in :email, with: "Jimmy@gmail.com"
        fill_in :password, with: "test"
        click_on "Submit"

        expect(current_path).to eq(user_path(@user2))

        visit root_path

        expect(page).to_not have_content("Log In")
        expect(page).to have_content("Log Out")

        click_on "Log Out"

        expect(page).to have_content("You have been successfully logged out.")
        expect(current_path).to eq(root_path)
      end
      it "visitor does not see list of existing users" do
        visit root_path

        expect(page).to_not have_content("#{@user1.name}")
        expect(page).to_not have_content("#{@user2.name}")
        expect(page).to_not have_content("#{@user3.name}")
        expect(page).to_not have_content("#{@user4.name}")
      end
    end

    context "sad path" do
      it 'cannot log in with bad credentials' do
        visit root_path
        click_on "Log In"

        fill_in :email, with: "Jimmy@gmail.com"
        fill_in :password, with: "test1"
        click_on "Submit"

        expect(page).to have_content("Sorry, your credentials are bad.")
        expect(current_path).to eq(sessions_path)
      end
    end
  end
end