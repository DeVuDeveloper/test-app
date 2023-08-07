require_relative "boot"

require "rails/all"
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CodingChallenge
  class Application < Rails::Application
    config.load_defaults 7.0

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end

    config.autoload_paths += %W[#{config.root}/app/jobs]

    config.generators.system_tests = nil

    config.proscenium.include_paths << "app/views"
    config.proscenium.include_paths << "app/components"
    config.proscenium.include_paths << "app/javascript"
  end
end
