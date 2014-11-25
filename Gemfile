source 'https://rubygems.org'
ruby '2.1.3'

gem 'bootstrap-sass', '3.1.1.1'
gem 'coffee-rails'
gem 'rails', '4.1.1'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
gem 'bcrypt'
gem 'sidekiq'
gem 'foreman'

group :development do
  gem 'sqlite3'
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'letter_opener'
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails', '2.99'
  gem 'fabrication'
  gem 'faker'
  gem 'capybara-email'
end

group :test do
  gem 'shoulda-matchers'
  gem 'database_cleaner', '1.2.0'
  gem 'capybara'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
