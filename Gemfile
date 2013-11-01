source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.2.14'         # Bundle edge? gem 'rails', :git => 'git://github.com/rails/rails.git'
gem 'bcrypt-ruby', '~> 3.0.0' # To use ActiveModel 'has_secure_password'
gem 'friendly_id'             # To get nice Urls
gem 'will_paginate'           # To use WillPaginate
gem 'bootstrap-will_paginate' # To use WillPaginate with bootstrap
gem 'haml'                    # To use Haml template engine
gem 'redcarpet'               # To use markdown in text fields
gem 'jquery-rails'

group :production do
  gem 'pg'
  gem 'rails_12factor' # to avoid heroku's gem injection!
end

group :development, :test do
  gem 'sqlite3'
  gem 'ruby-debug19'
#TODO try following gems
#  gem 'railroady'   # creates an UML diagramm
#  gem 'simpleCov'   # find code coverage beneath /coverage/index.html, or 'RCov'!?
#  gem 'metric_fu''  # invoke with '$ rake metrics' instead of simple '$ rake stats'
  gem 'meta_request' # Chrome extension, which provides insights to db/rendering/parameter list ...
end

group :test do
  gem 'rspec-rails'        # specification driven framework
  gem 'database_cleaner'   # to clear between test-runs Rspec/Cucumber's database  
  gem 'factory_girl_rails' # create factorys instead of fixures
  gem 'capybara'           # lets RSpec/Cucumber pretend to be a web browser
  gem 'launchy'            # a useful debugging aid for user stories, launches browser at breakpoint

  gem 'spork-rails'
  gem 'guard-rspec' # run automatic rspec tests
  gem 'guard-spork'
  gem 'rb-inotify', '~> 0.9' # guard dependency
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
