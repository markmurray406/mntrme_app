# See Listing 10.26
require 'spec_helper'

describe "Skill pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "skill creation" do
    # Change this to another page
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a skill" do
        expect { click_button "Add" }.not_to change(Skill, :count)
      end

      describe "error messages" do
        before { click_button "Add" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'skill_content', with: "Lorem ipsum" }
      it "should create a skill" do
        expect { click_button "Add" }.to change(Skill, :count).by(1)
      end
    end
  end # End of Skill Creation

    describe "skill destruction" do
    before { FactoryGirl.create(:skill, user: user) }

    describe "as correct user" do
      # need to change this
      before { visit root_path }

      it "should delete a skill" do
        expect { click_link "delete" }.to change(Skill, :count).by(-1)
      end
    end
  end # End of Skill Destruction
end