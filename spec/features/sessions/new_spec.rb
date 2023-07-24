require 'rails_helper'

RSpec.describe "Sessions" do
  describe 'happy path' do 
    it 'once user registers they are taken to the users dashboard' do
      visit register_path
      
      fill_in 'Name', with: 'Jonah Hill'
        fill_in 'Email Address', with: 'Jhill@gmail.com'
        fill_in :user_password, with: 'test'
        fill_in :user_password_confirmation, with: 'test'

        click_button 'Register'

        created_user = User.last

        expect(current_path).to eq(user_path(created_user))
    end
    it 'logged in user does not render log in button' do
      @user1 = User.create!(name: 'Sarah', email: 'Sarah@gmail.com', password: 'test', password_confirmation: 'test')
      visit register_path
        
    end
  end

  context "sad path" do
    it "displays flash error if password and password confirmation does not match" do
      visit register_path
      
      fill_in 'Name', with: 'Jonah Hill'
      fill_in 'Email Address', with: 'Jhill@gmail.com'
      fill_in :user_password, with: 'test'
      fill_in :user_password_confirmation, with: 'test1'
      click_button 'Register'

      expect(current_path).to eq(users_path)
      expect(page).to have_content("Invalid Credentials, Please Try Again")
    end   

    it "displays flash error if email is not unique" do
      visit register_path

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