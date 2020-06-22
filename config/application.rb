require_relative 'boot'

require 'rails/all'
require "action_cable/engine"

unless Rails.env.production?
  require 'dotenv'
end
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Keybate
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.api_only = true

    config.middleware.use ActionDispatch::Cookies # Required for all session management
    config.middleware.use ActionDispatch::Session::CookieStore, config.session_options

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    config.active_record.time_zone_aware_types = [:datetime, :time]

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.halt_callback_chains_on_return_false = false

    # Do not swallow errors in after_commit/after_rollback callbacks.
    # config.active_record.raise_in_transactional_callbacks = true

    # Use https in development.
    # config.force_ssl = true

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*',
          :headers => :any,
          :expose  => ['access-token', 'expiry', 'token-type', 'uid', 'client'],
          :methods => [:get, :post, :delete, :put, :patch, :options, :head]
      end
    end

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
  end
end
