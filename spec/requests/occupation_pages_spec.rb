require 'spec_helper'

describe "Occupation pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "occupation creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a occupation" do
        expect { click_button "Add" }.not_to change(Occupation, :count)
      end

      describe "error messages" do
        before { click_button "Add" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'occupation_content', with: "Lorem ipsum" }
      it "should create a occupation" do
        expect { click_button "Add" }.to change(Occupation, :count).by(1)
      end
    end
  end

  # See Listing 10.45, Testing that occupation count is reduced by 1 when delete link is pressed.
  describe "occupation destruction" do
    before { FactoryGirl.create(:occupation, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a occupation" do
        expect { click_link "delete" }.to change(Occupation, :count).by(-1)
      end
    end
  end

  # SEE LISTING 10.16
  describe "occupation page" do
    let(:occupation) { FactoryGirl.create(:occupation) }
    let!(:s1) { FactoryGirl.create(:skill, occupation: occupation, content: "Foo") }
    let!(:s2) { FactoryGirl.create(:skill, occupation: occupation, content: "Bar") }

    before { visit occupation_path(occupation) }

    it { should have_content(occupation.content) }

    describe "skills" do
      it { should have_content(s1.content) }
      it { should have_content(s2.content) }
      it { should have_content(occupation.skills.count) }
    end
  end

end