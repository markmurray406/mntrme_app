require 'spec_helper'
describe "User pages" do

  subject { page }

  describe "profile page" do
  	# See Listing 7.9. This creates a user based on the factories.rb file in the spec folder.
    let(:user) { FactoryGirl.create(:user) }

    # Replace with code to make a user variable
  	before { visit user_path(user) }

  	# Test 2: Test that the show page contains the users name.
  	it { should have_content(user.name) }
	end

  describe "signup page" do
    before { visit usersignup_path }

    # Removed Test 1: Signup should appear on the page
    #it { should have_content('Sign up') }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      # Test 3: Inserting invalid data does not increase the number of users, See Listing 7.16
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        # Test 4: Inserting valid data from above the number of users increases, See Listing 7.16
        expect { click_button submit }.to change(User, :count).by(1)
      end

      # Test 5: Testing that newly signed-up users are also signed in, See Listing 8.26.
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end
end
