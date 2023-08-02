source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "bootsnap", require: false
gem "devise"
gem "jbuilder"
gem "proscenium"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.6"
gem "sqlite3", "~> 1.4"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "simple_form", "~> 5.1.0"
gem "turbo-rails"
gem "stimulus-rails"
gem "view_component"
gem "redis"
gem "sidekiq"

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails"
  gem "rspec-viewcomponent"
end

group :development do
  gem "web-console"
  gem "standard"
end

group :test do
  gem "capybara"
  gem "rails-controller-testing" # deprecated
  gem "selenium-webdriver"
  gem "shoulda-matchers"
end
