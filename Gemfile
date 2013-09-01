source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.2.14'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
  gem 'sqlite3'
  gem 'ruby-debug19' #, :require => 'ruby-debug'
  gem 'rspec-rails' # specification driven framework
#TODO try following gems
#  gem 'railroady' # creates an UML diagramm
#  gem 'simpleCov' # find code coverage beneath /coverage/index.html, or 'RCov'!?
#  gem 'metric_fu'' # invoke bei '$ rake metrics' instead of simple '$ rake stats'
end

group :test do
  gem 'factory_girl_rails' # create factorys instead of fixures
  gem 'capybara' # lets RSpec/Cucumber pretend to be a web browser

#  gem 'cucumber-rails', :require => false # user story framework
#  gem 'cucumber-rails-training-wheels' # some pre-fabbed step definitions
  gem 'database_cleaner' # to clear Cucumber's test database between runs  
  gem 'launchy' # a useful debugging aid for user stories, launches browser at breakpoint

  gem 'spork-rails'

  gem 'guard-rspec' # run automatic rspec tests
  gem 'guard-spork'
  gem 'rb-inotify', '~> 0.8.8' # guard dependency
end

group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  #gem 'therubyracer', :platforms => :ruby
  #
  # See https://github.com/seyhunak/twitter-bootstrap-rails, just using STATIC version: 
  # $ rails generate bootstrap:install static
  #gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
  gem 'twitter-bootstrap-rails'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# To use WillPaginate
gem 'will_paginate'
gem 'bootstrap-will_paginate'

# To use markdown in text fields
gem 'redcarpet'

# To get nice Urls
gem 'friendly_id'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
