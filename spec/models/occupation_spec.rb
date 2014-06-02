require 'spec_helper'

describe Occupation do
	# See Listing 10.2
	# This creates a new user
  let(:user) { FactoryGirl.create(:user) }
  # See text above Listing 10.5, this replaces/reduces the code hidden below. 
  before { @occupation = user.occupations.build(content: "Lorem ipsum") }
  #before do
    # This code is not idiomatically correct.
    # This creates a new occupation withe the contnet Lorem ipsum, and establishes an idea of the generated user id.
    #@occupation = Occupation.new(content: "Lorem ipsum", user_id: user.id)
  #end

  subject { @occupation }
	# This tests that their should be content and a user id.
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  # See Listing 10.5
  it { should respond_to(:user) }
  its(:user) { should eq user }

	# Testing for validity of the occupation, See Listing 10.3
  it { should be_valid }

	# As shown in Listing 10.3, the validation test for user id just sets the id to nil and then checks that the resulting micropost is invalid.
  describe "when user_id is not present" do
    before { @occupation.user_id = nil }
    it { should_not be_valid }
  end

  # See Listing 10.14
  describe "with blank content" do
    before { @occupation.content = " " }
    it { should_not be_valid }
  end

  # See Listing 10.14
  describe "with content that is too long" do
    before { @occupation.content = "a" * 141 }
    it { should_not be_valid }
  end

  # ADDED 02-MAY-14, SEE LISTING 10.10
  describe "skill associations" do

    before { @occupation.save }
    let!(:older_skill) do
      FactoryGirl.create(:skill, occupation: @occupation, created_at: 1.day.ago)
    end
    let!(:newer_skill) do
      FactoryGirl.create(:skill, occupation: @occupation, created_at: 1.hour.ago)
    end

    # ADDED 02-MAY-14, SEE LISTING 10.10
    it "should have the right skills in the right order" do
      expect(@occupation.skills.to_a).to eq [newer_skill, older_skill]
    end

    # ADDED 02-MAY-14, SEE LISTING 10.12
    it "should destroy associated skills" do
      skills = @occupation.skills.to_a
      @occupation.destroy
      expect(skills).not_to be_empty
      skills.each do |skill|
        expect(Skill.where(id: skill.id)).to be_empty
      end
    end

  end #END OF SKILL ASSOCIATIONS
end
