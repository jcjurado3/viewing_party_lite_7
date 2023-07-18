require 'rails_helper'

RSpec.describe 'New Viewing Page', type: :feature do
  before(:each) do
    @user1 = User.create!(name: 'Sarah', email: 'sarah@gmail.com', password: 'test', password_confirmation: 'test')
    @user2 = User.create!(name: 'James', email: 'James@gmail.com', password: 'test', password_confirmation: 'test')
    @user3 = User.create!(name: 'Jimi', email: 'Jimi@gmail.com', password: 'test', password_confirmation: 'test')

    movies = SearchFacade.new.movies
    @movie = movies.first
    visit new_viewing_party_path(@user1, @movie.id)
  end  
  describe "new viewing party form page" do
    it "displays form fields", :vcr do
      expect(current_path).to eq(new_viewing_party_path(@user1, @movie.id))

      expect(page).to have_content("#{@movie.title}")

      expect(page).to have_content("Duration of Viewing Party in Minutes")
      expect(page).to have_field(:duration)

      expect(page).to have_field("When is the viewing party")
      expect(page).to have_field(:date)

      expect(page).to have_content("Start Time")
      expect(page).to have_field(:time)
      
      expect(page).to have_content("#{@user2.name}")

      expect(page).to have_button("Create Party")

    end

    it "can create a new viewing party", :vcr do
      fill_in :duration, with: "175"
      fill_in :date, with: '2023/07/09'
      fill_in :time, with: '9:00'
      check @user2.id
      
      click_button("Create Party")

      

      expect(current_path).to eq(user_path(@user1))
     
      # expect(page).to have_content("#{@movie.title}")
      # expect(page).to have_link("#{@movie.title}")

      expect(page).to have_content("2023-07-09")
      expect(page).to have_content("Saturday, January 1, 2000")

      
      expect(page).to have_content("#{@user1.name}")
      # expect(page).to have_content("#{@user2.name}")





    end  

    xit 'cannot be less than movie runtime', :vcr do
      fill_in :duration, with: '174'

      click_button('Create Party')

      expect(current_path).to eq(new_viewing_party_path(@user1, @movie.id))
      
    end
  end  
end  