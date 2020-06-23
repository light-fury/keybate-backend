source 'https://rubygems.org'
ruby '2.3.0'

gem 'aws-sdk', '~> 2'
gem 'carrierwave', '~> 0.10.0'
gem 'jbuilder'
gem 'knock'
gem 'pg', '~> 0.18.1'
gem 'puma', '~> 3.12'
gem 'pusher', '>= 1.2.0'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 5.0.1'
gem 'responders'
gem 'devise_token_auth'
gem 'omniauth', '~> 1.0'
gem 'omniauth-facebook'
gem 'omniauth-linkedin-oauth2'
gem 'omniauth-oauth2', '~> 1.3.1'
gem "rolify"
gem "pundit"
gem 'cloudinary'

# Remove after cleaning up serializers and unused controllers
gem 'active_model_serializers', '~> 0.10'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  # To save ENV variables in development.
  gem 'dotenv-rails'

  gem 'ffaker'
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.5'
end

group :test do
  gem 'shoulda-matchers', '~> 3.1'
  gem 'shoulda-callback-matchers', '~> 1.1.1'
  gem 'pundit-matchers', '~> 1.3.0', require: false
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'seed_dump'
end

group :production do
  gem 'rails_12factor'
  gem 'redis'
end
