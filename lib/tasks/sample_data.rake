# See Listing 9.29
namespace :db do
  desc "Fill database with sample data"
  # ensures that the Rake task has access to the local Rails environment, including the User model 
  task populate: :environment do
    # See Listing 9.40
    admin = User.create!(name: "Example User",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar",
                         admin: true)

    #User.create!(name: "Example User",
    #             email: "example@railstutorial.org",
    #             password: "foobar",
    #             password_confirmation: "foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end