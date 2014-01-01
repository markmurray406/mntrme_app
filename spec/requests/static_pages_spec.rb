require 'spec_helper'

describe "Static pages" do

subject { page }
describe "Home page" do
  #This tells the test (Capybara) to visit the home page as described in the routes.rb file
   before { visit root_path }

  #Test 1: Mntr Me is mentioned on the page.
  it { should have_content('Mntr Me') }
  #Test 2: Mntr Me shows in the tab of a browser.
  it { should have_title("Mntr Me") }
end

describe "Help page" do
  #This tells the test (Capybara) to visit the help page as described in the routes.rb file
   before { visit help_path }

  #Test 3: Help is mentioned on the page.
  it { should have_content('Help') }
end

describe "About page" do
  #This tells the test (Capybara) to visit the about page as described in the routes.rb file
   before { visit about_path }

  #Test 4: About is mentioned on the page.
  it { should have_content('About') }
end

  describe "Contact page" do
  #This tells the test (Capybara) to visit the contact page as described in the routes.rb file
   before { visit contact_path }

  #Test 5: Contact is mentioned on the page.
  it { should have_content('Contact') }
  end
end
