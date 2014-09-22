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

  # See Listing 10.9
  factory :occupation do
    content "Lorem ipsum"
    user
  end

  # See Listing 10.9
  factory :skill do
    content "Lorem ipsum"
    user
    occupation # Add 02-May-14
  end

    # See Listing 10.9
  factory :resource do
    content "Lorem ipsum"
    user
    occupation # Add 02-May-14
  end
end