require 'spec_helper'

describe "Authentication" do

  subject { page }

  # T1
  describe "signin page" do
    before { visit signin_path }
    # Test 1
    it { should have_content('Sign in') }

    # See Listing 8.5
    describe "with invalid information" do
      before { click_button "Sign in" }
      # Test 2 if form is filled with invalid information, and alert header should appear. 
      it { should have_selector('div.alert.alert-error') }

      # See Listing 8.11
      describe "after visiting another page" do
        before { click_link "Home" }
        # Test 3. Home page (or other pages) should not have the signin error flash
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    # See Listing 8.6
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end
      # Tests 3-5, see Listing 8.6
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      # Tests 6, see Listing 8.28
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end  
    end
  end
end
