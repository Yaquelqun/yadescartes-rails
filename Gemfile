source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

gem "rails", "~> 7.0.2", ">= 7.0.2.3"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "jbuilder"
gem "redis", "~> 4.0"
gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "rack-cors"
gem 'config', '~> 4.0'
gem 'graphql', '~> 2.0', '>= 2.0.2'
gem 'jwt', '~> 2.2', '>= 2.2.2'

group :development, :test do
  gem "byebug"
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'capybara', '~> 3.36'
  gem 'dotenv-rails', '~> 2.7', '>= 2.7.6'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'rspec-rails', '~> 6.0.0.rc1'
  gem 'rubocop', '~> 1.30', '>= 1.30.1'
  gem 'rubocop-rails', '~> 2.14', '>= 2.14.2'
  gem 'rubocop-rspec', '~> 2.11', '>= 2.11.1'
  gem 'simplecov', '~> 0.21.2'
  gem 'faker', '~> 2.20'
end

group :development do
  gem 'graphiql-rails'
end

