require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application

    config.load_defaults 6.1

    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]
    config.time_zone = "Tokyo"
    config.active_record.default_timezone = :local

    config.generators do |g|
      g.text_framework :rspec,
        view_specs: false,
        helper_specs: false,
        routing_specs: false
    end

  end

end
