require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    #This tells the tester what we are testing for
    it "should have the content 'Mntr Me'" do
    	#This tells the test (Capybara) to visit the home page in the static_pags folder
      visit '/static_pages/home'
      #This is the test (Capybara) request
      expect(page).to have_content('Mntr Me')
    end
  end

  describe "Help page" do

    #This tells the tester what we are testing for
    it "should have the content 'Help'" do
    	#This tells the test (Capybara) to visit the help page in the static_pags folder
      visit '/static_pages/help'
      #This is the test (Capybara) request
      expect(page).to have_content('Help')
    end
  end

  describe "About page" do
    
    #This tells the tester what we are testing for
    it "should have the content 'About Us'" do
    	#This tells the test (Capybara) to visit the about page in the static_pags folder
      visit '/static_pages/about'
      #This is the test (Capybara) request
      expect(page).to have_content('About Us')
    end
  end

  describe "Contact page" do
    
    #This tells the tester what we are testing for
    it "should have the content 'Contact'" do
    	#This tells the test (Capybara) to visit the contact page in the static_pags folder
      visit '/static_pages/contact'
      #This is the test (Capybara) request
      expect(page).to have_content('Contact')
    end
  end
end
