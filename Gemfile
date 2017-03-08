source 'https://rubygems.org'

ruby '2.3.0'

gem 'react_on_rails', '~> 6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use postgresql as the database for Active Record
gem 'pg'
gem 'sprockets', '3.6.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'will_paginate', '3.0.7'
gem 'possessive'

gem 'carrierwave', github: "carrierwaveuploader/carrierwave"
gem 'fog-aws'
gem 'mini_magick'

# The only way I found to install libv8 and therubyracer successfully is as follows:
#  installed xcode from app store
#  gem uninstall libv8 therubyracer (if previously installed)
#  brew install homebrew/versions/v8-315
#  brew link --overwrite v8-315 --force
#  gem install libv8 -v '3.16.14.13' -- --with-system-v8
#  gem install therubyracer -v '0.12.2' -- --with-system-v8

gem 'foreman'
gem 'puma'
gem 'underscore-rails'
gem 'gmaps4rails'
gem 'geocoder'
gem 'figaro'
gem 'libv8', '~> 3.16.14.0'
# gem 'mini_racer', platforms: :ruby
gem 'therubyracer', '~> 0.12'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'rspec-rails', '~> 3.5'
  gem 'pry-rails'
  gem 'quiet_assets', '~> 1.0.3'
  gem 'capybara'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'database_cleaner'
  gem 'faker'
  gem 'capybara-webkit'
  gem 'shoulda-matchers', '~> 3.0'
end

group :production do
  gem 'rails_12factor'
end
