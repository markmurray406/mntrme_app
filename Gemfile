source 'https://rubygems.org'
ruby '2.0.0'
#ruby-gemset=railstutorial_rails_4_0
#source: http://ruby.railstutorial.org/chapters/static-pages#top

gem 'rails', '4.0.2'
# Added thin gem as app was not loading on Heroku, 27-Dec-2013
gem 'thin'

group :development, :test do
  gem 'sqlite3', '1.3.8'
  # We don’t have to install RSpec itself because it is a dependency of rspec-rails and will thus be installed automatically
  gem 'rspec-rails', '2.13.1'
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  #Capybara allows us to simulate a user’s interaction with the sample application using a natural English-like syntax
  gem 'capybara', '2.1.0'
end

gem 'sass-rails', '4.0.1'
gem 'uglifier', '2.1.1'
gem 'coffee-rails', '4.0.1'
gem 'jquery-rails', '3.0.4'
gem 'turbolinks', '1.1.1'
gem 'jbuilder', '1.0.2'

group :doc do
  gem 'sdoc', '0.3.20', require: false
end

group :production do
	#PostgreSQL and static assets gems in production for deployment to Heroku:
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end