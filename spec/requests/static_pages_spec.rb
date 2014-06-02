require 'spec_helper'

describe "Static pages" do

subject { page }
  # See Listing 5.39
  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
  end


describe "Home page" do
  #This tells the test (Capybara) to visit the home page as described in the routes.rb file
   before { visit root_path }

  #Test 1: Mntr Me is mentioned on the page, # See Listing 5.39
  let(:heading)    { 'Mntr Me' }
  it_should_behave_like "all static pages"

  #Test 2: Mntr Me shows in the tab of a browser.
  it { should have_title("Mntr Me") }

  #Test 3: This tests the Links to make sure it goes to the correct place.
  # http://stackoverflow.com/questions/11916962/how-to-keep-rspec-tests-dry-with-lots-of-have-link
  it { should have_link('Sign up now!', href: usersignup_path) }
  
  #Header - Tests 4 and 5.
  it { should have_link('Home', href: root_path) }
  it { should have_link('Help', href: help_path) }

  #Footer - Test 6 and 7.
  it { should have_link('About', href: about_path) }
  it { should have_link('Contact', href: contact_path) }

  # See Listing 10.37, A test for rendering the feed on the Home page. 
  describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:occupation, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:occupation, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end # End of "for signed-in users, see Listing 10.37"

end # End of Home page.

describe "Help page" do
  #This tells the test (Capybara) to visit the help page as described in the routes.rb file
   before { visit help_path }

  #Test 8: Help is mentioned on the page.
  let(:heading)    { 'Help' }
  it_should_behave_like "all static pages"
end

describe "About page" do
  #This tells the test (Capybara) to visit the about page as described in the routes.rb file
   before { visit about_path }

  #Test 9: About is mentioned on the page.
  let(:heading)    { 'About' }
  it_should_behave_like "all static pages"
end

  describe "Contact page" do
  #This tells the test (Capybara) to visit the contact page as described in the routes.rb file
   before { visit contact_path }

  #Test 10: Contact is mentioned on the page.
  #it { should have_content('Contact') }
  let(:heading)    { 'Contact' }
  it_should_behave_like "all static pages"
  end

end
