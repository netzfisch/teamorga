source 'https://rubygems.org'
ruby '1.9.3'

gem 'unicorn'                 # robust production server

gem 'rails', '3.2.18'         # Bundle edge? gem 'rails', :git => 'git://github.com/rails/rails.git'
gem 'bcrypt-ruby', '~> 3.0.0' # To use ActiveModel 'has_secure_password'
gem 'friendly_id'             # To get nice Urls
gem 'will_paginate'           # To use WillPaginate
gem 'will_paginate-bootstrap', "~> 1.0.0" # To use WillPaginate with bootstrap
gem 'haml'                    # To use Haml template engine
gem 'redcarpet'               # To use markdown in text fields
gem 'jquery-rails'

group :production do
  gem 'pg'
  gem 'rails_12factor' # to avoid heroku's gem injection!
end

group :development, :test do
  gem 'sqlite3'
  gem 'foreman'     # start all associated processes via 'Procfile'
  gem 'rspec-rails', '2.99' # specification driven framework
  gem 'spring-commands-rspec' # prefork rails app for faster test
  gem 'guard-rspec', '~> 4.0' # run automatic rspec tests
  gem 'rb-inotify', '~> 0.9' # guard dependency
  gem 'ruby-debug19'
#TODO try following gems
#  gem 'railroady'   # creates an UML diagramm
#  gem 'simpleCov'   # find code coverage beneath /coverage/index.html, or 'RCov'!?
#  gem 'metric_fu''  # invoke with '$ rake metrics' instead of simple '$ rake stats'
  gem 'meta_request' # Chrome extension, which provides insights to db/rendering/parameter list ...
end

group :test do
  gem 'database_cleaner'   # to clear between test-runs Rspec/Cucumber's database
  gem 'factory_girl_rails' # create factorys instead of fixures
  gem 'capybara'           # lets RSpec/Cucumber pretend to be a web browser
  gem 'launchy'            # a useful debugging aid for user stories, launches browser at breakpoint
# gem 'spork-rails'
# gem 'guard-spork'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
# See https://github.com/seyhunak/twitter-bootstrap-rails, just using STATIC version:
# $ rails generate bootstrap:install static
# gem 'twitter-bootstrap-rails'
#
# Switch to bootstrap 3.x and SASS
  gem 'bootstrap-sass', '~> 3.0.1.0.rc'
end

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
