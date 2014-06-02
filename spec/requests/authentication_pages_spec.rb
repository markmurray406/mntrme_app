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
      # Test 6. See Listing 9.5, this line only
      before { sign_in user }
      #before do
      #  fill_in "Email",    with: user.email.upcase
      #  fill_in "Password", with: user.password
      #  click_button "Sign in"
      #end

      # See Listing 9.26
      it { should have_link('Users', href: users_path) }
      # Tests 3-5, see Listing 8.6
      it { should have_link('Profile', href: user_path(user)) }
      # Test 6. See Listing 9.5, this line only
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      # Tests 6, see Listing 8.28
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end  
    end
  end

  # See Listing 9.11
  describe "authorization" do

    # See Listing 9.16, test for friendly forwarding.
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        #describe "after signing in" do
          # See Lisitng 9.16 for missing test
        #end
      end

      # See Listing 10.23
      describe "in the Occupations controller" do

        describe "submitting to the create action" do
          before { post occupations_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete occupation_path(FactoryGirl.create(:occupation)) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end

      # See Listing 10.23
      describe "in the Skills controller" do

        describe "submitting to the create action" do
          before { post skills_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete skill_path(FactoryGirl.create(:skill)) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
    # DON'T KNOW IF THIS END IS CORRECT  
    end  # End of "for non-signed-in users"

    describe "in the Users controller" do

        #describe "visiting the edit page" do
        #  before { visit edit_user_path(user) }
        #  it { should have_title('Sign in') }
        #end

      describe "submitting to the update action" do # This is failing
        # Access a controller action: by issuing the appropriate HTTP request directly, in this case using the patch method to issue a PATCH request:
        # This issues a PATCH request directly to /users/1, which gets routed to the update action of the Users controller (Table 7.1)
        before { put user_path(user) }
        specify { response.should redirect_to(signin_path) }
      end

      describe "visiting the user index" do
        before { visit users_path }
      end
    end

    # Listing 9.13. Testing that the edit and update actions require the right user. 
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      # This creates a user with a different email address from the default.
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        #specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end 

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin }

      describe "submitting a DELETE request to the Users#destroy action" do # This is failing
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_url) } 
      end
    end



  end # End of suthorization
end # End of Authentication
