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
                         admin: true,
                         company: true)

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

    # See Listing 10.20 Adding Occupations to sample data
    users = User.all(limit: 6)
    10.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.occupations.create!(content: content) }
      users.each { |user| user.skills.create!(content: content) }
      users.each { |user| user.resources.create!(content: content) }
    end
  end
end