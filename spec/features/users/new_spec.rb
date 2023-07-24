require 'rails_helper'

RSpec.describe "/register", type: :feature do
  before(:each) do
    visit register_path
  end
  describe "As a visitor, when I visit the user registration page" do
    context "new user form fields" do
      it 'displays form with Name field' do
        expect(page).to have_field("Name:")
      end

      it 'displays form with Email field' do
        expect(page).to have_field("Email Address:")
      end

      it 'display form with Password field' do
        expect(page).to have_field("Password")
      end

      it 'display form with Password Confirmation field' do
        expect(page).to have_field("Password Confirmation")
      end

      it 'display form with Register Button' do
        expect(page).to have_button("Register")
      end
    end

    context "happy path" do 
      it 'once user registers they are taken to the users dashboard' do
        fill_in 'Name', with: 'Jonah Hill'
        fill_in 'Email Address', with: 'Jhill@gmail.com'
        fill_in :user_password, with: 'test'
        fill_in :user_password_confirmation, with: 'test'

        click_button 'Register'

        created_user = User.last

        expect(current_path).to eq(user_path(created_user))
      end

      
    end

    context "sad path" do
      it "displays flash error if password and password confirmation does not match" do
        fill_in 'Name', with: 'Jonah Hill'
        fill_in 'Email Address', with: 'Jhill@gmail.com'
        fill_in :user_password, with: 'test'
        fill_in :user_password_confirmation, with: 'test1'
        click_button 'Register'

        expect(current_path).to eq(users_path)
        expect(page).to have_content("Invalid Credentials, Please Try Again")
      end   

      it "displays flash error if email is not unique" do
        fill_in 'Name', with: 'Jonah Hill'
        fill_in 'Email Address', with: 'Jhill@gmail.com'
        fill_in :user_password, with: 'test'
        fill_in :user_password_confirmation, with: 'test'
        click_button 'Register'

        created_user = User.last
        expect(current_path).to eq(user_path(created_user))

        visit register_path

        fill_in 'Name', with: 'James Hill'
        fill_in 'Email Address', with: 'Jhill@gmail.com'
        fill_in :user_password, with: 'test'
        fill_in :user_password_confirmation, with: 'test'
        click_button 'Register'

        expect(current_path).to eq(users_path)
        expect(page).to have_content("Invalid Credentials, Please Try Again")
      end
    end
  end
end