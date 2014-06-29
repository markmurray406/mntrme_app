require 'spec_helper'
describe "User pages" do

  subject { page }

  # See Listing 9.22 and 9.32
  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_content('All users') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    # See Listing 9.42
    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end

  describe "profile page" do
  	# See Listing 7.9. This creates a user based on the factories.rb file in the spec folder.
    let(:user) { FactoryGirl.create(:user) }
    # See Listing 10.16. This creates an occupation based on the factories.rb file in the spec folder with the content Foo and Bar.
    let!(:m1) { FactoryGirl.create(:occupation, user: user, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:occupation, user: user, content: "Bar") }
    
    let!(:m3) { FactoryGirl.create(:skill, user: user, content: "Foo") }
    let!(:m4) { FactoryGirl.create(:skill, user: user, content: "Bar") }

    let!(:m5) { FactoryGirl.create(:resource, user: user, content: "Foo") }
    let!(:m6) { FactoryGirl.create(:resource, user: user, content: "Bar") }

    # Replace with code to make a user variable
  	before { visit user_path(user) }

  	# Test 2: Test that the show page contains the users name.
  	it { should have_content(user.name) }

    # See Listing 10.16. These are what we are testing for. m1 and m2 are the object listed above.
    describe "occupations" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.occupations.count) }
    end

    # See Listing 10.16. These are what we are testing for. m1 and m2 are the object listed above.
    describe "skills" do
      it { should have_content(m3.content) }
      it { should have_content(m4.content) }
      it { should have_content(user.skills.count) }
    end

    # See Listing 10.16. These are what we are testing for. m1 and m2 are the object listed above.
    describe "resources" do
      it { should have_content(m5.content) }
      it { should have_content(m6.content) }
      it { should have_content(user.skills.count) }
    end
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

  # See Listing 9.1. and 9.9 Testing for the User edit page.
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end  

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }
      it { should have_content('error') }
    end

    # See Listing 9.9 Tests for the user update action. 
    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      # This reloads the user variable from the test database using user.reload, and then verifies that the user’s new name and email match the new values.
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end
