# See Listing 10.2
require 'spec_helper'

describe Skill do

  # See Listing 10.3
  #let(:user) { FactoryGirl.create(:user) }
  #before { @skill = user.skills.build(content: "Lorem ipsum") }
  let(:user) { FactoryGirl.create(:user) } # Not sure this is correct, 02-May-14
  before { @occupation = user.occupations.build(content: "Lorem ipsum") } # Not sure this is correct, 02-May-14
  let(:occupation) { FactoryGirl.create(:occupation) }
  before { @skill = occupation.skills.build(content: "Lorem ipsum") }

  subject { @skill }

  it { should respond_to(:content) }
  #it { should respond_to(:user_id) }
  #it { should respond_to(:user) }
  #its(:user) { should eq user }

  # Added 20-April
  it { should respond_to(:occupation_id) }
  it { should respond_to(:occupation) }
  #its(:occupation) { should eq occupation }

  it { should be_valid }

  # See Listing 10.3
  #describe "when user_id is not present" do
  #  before { @skill.user_id = nil }
  #  it { should_not be_valid }
  #end
  describe "when occupation_id is not present" do
    before { @skill.occupation_id = nil }
    it { should_not be_valid }
  end

 # See Listing 10.14
  describe "when user_id is not present" do
    before { @skill.user_id = nil }
    it { should_not be_valid }
  end

 # See Listing 10.14
  describe "with blank content" do
    before { @skill.content = " " }
    it { should_not be_valid }
  end

 # See Listing 10.14
  describe "with content that is too long" do
    before { @skill.content = "a" * 141 }
    it { should_not be_valid }
  end
end

