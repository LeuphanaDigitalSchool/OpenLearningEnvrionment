# frozen_string_literal: true
source 'https://rubygems.org'

gem 'rails', '~> 5.0.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'config'
gem 'active_model_serializers', '~> 0.10.0'
gem 'devise_token_auth'
gem 'rack-cors', require: 'rack/cors'
gem 'apitome' # Api docs reader
gem 'carrierwave'
gem 'carrierwave-base64'
gem 'mini_magick'

group :development, :test do
  gem 'pry'
  gem 'rubocop'
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'database_cleaner'
  gem 'byebug', platform: :mri
  gem 'rspec_api_documentation'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'capistrano'
  gem 'capistrano-rvm'
  gem 'capistrano-rails'
  gem 'capistrano3-puma'
  gem 'capistrano-bundler'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
