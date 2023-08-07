source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "bootsnap", require: false
gem "devise"
gem "jbuilder"
gem "pg", "~> 1.1"
gem "proscenium"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.6"
gem "redis"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "simple_form", "~> 5.1.0"
gem "stimulus-rails"
gem "turbo-rails"
gem "view_component"

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails"
  gem "rspec-viewcomponent"
end

group :development do
  gem "standard"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "rails-controller-testing" # deprecated
  gem "selenium-webdriver"
  gem "shoulda-matchers"
end
gem "timecop"
