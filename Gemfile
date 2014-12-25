source 'http://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.8'

ruby '2.1.5'

# Use postgresql as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails'
gem 'compass-rails'
gem 'bootstrap-sass'

gem 'haml'

# Русская локализация методов
gem 'russian', '~> 0.6.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', :platforms => :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Передача переменных Ruby в JS
gem 'gon'

# Пагинация
gem 'will_paginate'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'yard'
end

group :development do
  # Лучше отображает ошибки
  gem "better_errors"
  gem "binding_of_caller"

  # Ловит почту
  gem 'mailcatcher'

  # Находит косяки в запросах к базе
  gem "bullet"

  gem 'spring'
end

gem 'capistrano', '~> 3.3.0'
gem 'capistrano-rails'
gem 'capistrano-bundler'
gem 'capistrano-passenger'
gem 'capistrano-rvm'
# gem 'capistrano-ec2group'

group :development, :test do
  gem 'rspec-rails'
  gem "mocha"
  gem 'capybara'
  gem 'selenium-webdriver'
end

group :production do
  gem 'exception_notification'
  gem 'activerecord-reset-pk-sequence'
end

gem "figaro"

gem 'redis-rails'

gem 'meta-tags', :require => 'meta_tags'

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', :require => 'bcrypt'

# Use unicorn as the app server
#gem 'unicorn'

# Use debugger
# gem 'debugger', group: [:development, :test]
