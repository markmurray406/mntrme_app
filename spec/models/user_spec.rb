require 'spec_helper'

describe User do

	# See Listing 6.5
  # before runs the code to create a new user Example with a example email.
  before do 
  	@user = User.new(name: "Example User", email: "user@example.com",
  									password: "foobar", password_confirmation: "foobar")
	end

	#subject makes the @user the subject of the test example
  subject { @user }

	# Test 1-2: for the existence of name and email attributes:
  it { should respond_to(:name) }
  it { should respond_to(:email) }
	# Test 10. See Listing 6.22, test that there is a cryptographic hash function.
  it { should respond_to(:password_digest) }
  # Test 11-12. Testing that password if present and matches the confirmed password before saving.
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  # Test 18 and 19, See Listing 8.15
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  #Test X See Listing 9.38
  it { should respond_to(:admin) }
  #Test X See Listing 10.6
  it { should respond_to(:occupations) }
  it { should respond_to(:skills) }
  it { should respond_to(:resources) }

  # Listing 10.35, test for the status feed.
  it { should respond_to(:feed) }

  # Test 3: See Listing 6.8 This is a sanity check, verifying that the subject (@user) is initially valid:
  it { should be_valid }
  #Test Y See Listing 9.38
  it { should_not be_admin }

  #Test Z See Listing 9.38
  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  # Test 4: See Listing 6.8 before block to set the user’s name to an invalid (blank) value and then checks that the resulting user object is not valid.
  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  # Test 5: Repeating Test 4 for email attribute.
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  # Test 6: Testing that the name does not exceed 51 characters.
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

	# Test 7: Testing that the email is inputted in an incorrect format.
  describe "when email format is invalid" do
  	# Provides examples of incorrect email formats e.g. user@foo,com, note the %w creates an array where each possible emtry is seperated by a blank space
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      # this runs the array, calling each option.
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

	# Test 8: Testing that the email is inputted in a correct format.
  describe "when email format is valid" do
    it "should be valid" do
    	# Provides examples of correct email formats
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      # this runs the array, calling each option.
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

	# Test 19. A test for email downcasing. see Listing 6.30
  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end 

 	# Test 9: Dupicating and saving the details above of the :user (using @user.dup) to the database.
 	# as the details of :user are already in the database we should be told that it can't save and is not valid
 	describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      # This creates the dup in uppercase.
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  # See Listing 6.25. Testing that password isn't present.
  # Test 13
  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  # Test 14 doesn't match confirmation password
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  # Test 15. Test to ensure the password is not too short.
  describe "with a password that's too short" do
  	before { @user.password = @user.password_confirmation = "a" * 5 }
		#If the user password and user confirmation password is less than 5 it should be invalid.
  	it { should be_invalid }
	end

	#Test 18: This is an overall test.
	describe "return value of authenticate method" do
		# saves the user to the database so that it can be retrieved using find_by
  	before { @user.save }
		# Creates a variable (:found_user using let) and makes it equal to find the user that is found by their email.
  	let(:found_user) { User.find_by(email: @user.email) }

  	#Test 16: Test that the stored password is equal to the given user password.
  	describe "with valid password" do
		#Test: the password should be equal (eq) to the users password.
    	it { should eq found_user.authenticate(@user.password) }
  	end

  	# Test 17: Test that an invalid password should not equal to the given user password.
  	describe "with invalid password" do
			# Creates a variable (:user_for_invalid_password) and makes it equal to find the user that has an invalid authentication.
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }

			#T: the password should not be equal (eq) to the invalid password. (note it and specify are synonyms).
    	it { should_not eq user_for_invalid_password }
    	specify { expect(user_for_invalid_password).to be_false }
  	end
	end

  # Test 20, See Listing 8.17
  describe "remember token" do
    before { @user.save }
    # Note the its method, see Listing 8.17
    its(:remember_token) { should_not be_blank }
  end

  # Test 20, See Listing 10.10
  describe "Occupation associations" do

    before { @user.save }
    let!(:older_occupation) do
      FactoryGirl.create(:occupation, user: @user, created_at: 1.day.ago)
    end
    # Note: Ensure to use let! not let, as let by itself is lazy. 
    let!(:newer_occupation) do
      FactoryGirl.create(:occupation, user: @user, created_at: 1.hour.ago)
    end

    # This indicated that the new occupation should be before the older occpation
    it "should have the right occupations in the right order" do
      expect(@user.occupations.to_a).to eq [newer_occupation, older_occupation]
    end

    # See Listing 0.12, this tests that the microsposts cn be destroyed.
    it "should destroy associated occupations" do
      occupations = @user.occupations.to_a
      @user.destroy
      expect(occupations).not_to be_empty
      occupations.each do |occupation|
        expect(Occupation.where(id: occupation.id)).to be_empty
      end
    end

    # See Listing 10.35 test for the status feed.
    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:occupation, user: FactoryGirl.create(:user))
      end

      its(:feed) { should include(newer_occupation) }
      its(:feed) { should include(older_occupation) }
      its(:feed) { should_not include(unfollowed_post) }
    end
  end # End of Occupation associations

  # Test 20, See Listing 10.10
  describe "Skill associations" do
    before { @user.save }
    let!(:older_skill) do
      FactoryGirl.create(:skill, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_skill) do
      FactoryGirl.create(:skill, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right skills in the right order" do
      expect(@user.skills.to_a).to eq [newer_skill, older_skill]
    end

    # Test 20, See Listing 10.12
    it "should destroy associated skills" do
      skills = @user.skills.to_a
      @user.destroy
      expect(skills).not_to be_empty
      skills.each do |skill|
        expect(Skill.where(id: skill.id)).to be_empty
      end
    end
  end # End of Skills Associations

  describe "resource associations" do

    before { @user.save }
    let!(:older_resource) do
      FactoryGirl.create(:resource, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_resource) do
      FactoryGirl.create(:resource, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right resources in the right order" do
      expect(@user.resources.to_a).to eq [newer_resource, older_resource]
    end

    # See Listing 10.12
    it "should destroy associated resources" do
      resources = @user.resources.to_a
      @user.destroy
      expect(resources).not_to be_empty
      resources.each do |resource|
        expect(Resource.where(id: resource.id)).to be_empty
      end
    end
  end  # End of Resources Associations

end # End of spec