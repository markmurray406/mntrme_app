# See Listing 7.8
FactoryGirl.define do
	# passing the symbol :user to the factory command tells Factory Girl 
	# that the subsequent definition is for a User model object.
  factory :user do
    #name     "Michael Hartl"
    #email    "michael@example.com"
    # See Listing 9.31, this creates a list of users automatically.
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    # See Listing 9.41
    factory :admin do
      admin true
    end
  end
end