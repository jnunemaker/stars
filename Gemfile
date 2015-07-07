source "https://rubygems.org"

ruby ENV["CUSTOM_RUBY_VERSION"] || "2.1.6"

gem "rails", "4.2.0"
gem "pg"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.1.0"
gem "jquery-rails"
gem "turbolinks"
gem "jbuilder", "~> 2.0"
gem "sdoc", "~> 0.4.0", group: :doc

gem "bootstrap-sass", "~> 3.3.3"
gem "bootstrap-kaminari-views"
gem "kaminari"
gem "local_time"
gem "octokit", "~> 3.0"
gem "omniauth-github"
gem "pg_hstore"
gem "puma"
gem "warden"

# for heroku
gem 'rails_12factor', group: :production

group :development, :test do
  gem "dotenv-rails"
  gem "foreman"
  gem "quiet_assets"

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug"

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console", "~> 2.0"

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
end

group :test do
  gem "webmock"
  gem "mocha"
end
