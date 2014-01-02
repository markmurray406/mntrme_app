require 'spec_helper'
describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit usersignup_path }

    # Test 1: Signup should appear on the page
    it { should have_content('Sign up') }

  end
end
