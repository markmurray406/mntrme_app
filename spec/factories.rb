# See Listing 7.8
FactoryGirl.define do
	# passing the symbol :user to the factory command tells Factory Girl 
	# that the subsequent definition is for a User model object.
  factory :user do
    name     "Michael Hartl"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end