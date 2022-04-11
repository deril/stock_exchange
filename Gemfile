# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.1'

gem 'acts_as_paranoid', '~> 0.8.0'
gem 'bootsnap', require: false
gem 'brakeman', '~> 5.2'
gem 'bundler-audit', '~> 0.9.0'
gem 'grape', '~> 1.6'
gem 'grape-entity', '~> 0.10.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.2', '>= 7.0.2.3'
gem 'sqlite3', '~> 1.4'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'rspec-rails', '~> 5.1'
  gem 'shoulda-matchers', '~> 5.1'
end

group :development do
  gem 'rubocop', '~> 1.27'
  gem 'rubocop-performance', '~> 1.13'
  gem 'rubocop-rails', '~> 2.14'
  gem 'rubocop-rspec', '~> 2.9'
end
