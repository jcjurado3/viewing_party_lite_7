require 'rails_helper'

RSpec.describe "User Log In Page" do
  before(:each) do
    @user1 = User.create!(name: 'Jimmy', email: 'Jimmy@gmail.com', password: 'test', password_confirmation: 'test')
  end
  describe "/ - root page" do
    context "happy path" do
      it "log in link" do
        visit root_path

        expect(page).to have_button("Log In")
        click_button "Log In"

        expect(current_path).to eq(new_session_path)
      end
      it "login form" do
        visit root_path
        click_on "Log In"

        fill_in :email, with: "Jimmy@gmail.com"
        fill_in :password, with: "test"
        click_on "Submit"

        expect(current_path).to eq(user_path(@user1))
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