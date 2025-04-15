require 'action_dispatch/middleware/remote_ip'
require 'stimulus-rails'
module DesignSystem
  # This is the main engine class for the design system.
  class Engine < ::Rails::Engine
    # Allow changes to the design system to be reloaded in development.
    config.autoload_paths << File.expand_path('..', __dir__) if Rails.env.development?

    initializer 'design_system.importmap', before: 'importmap' do |app|
      app.config.importmap.paths << Engine.root.join('config/importmap.rb')
      app.config.importmap.cache_sweepers << Engine.root.join('app/assets/javascripts')
    end

    initializer 'design_system.assets.precompile' do |app|
      app.config.assets.precompile += %w[design_system/controllers/index.js]
    end

    # Adding Rack::Static to serve up assets from the design_systems
    initializer 'design_system.add_middleware' do |app|
      app.middleware.insert_after(
        ::ActionDispatch::RemoteIp,
        ::Rack::Static,
        urls: [
          '/design_system/static/date-fns-4.1.0',
          '/design_system/static/govuk-frontend-5.9.0',
          '/design_system/static/hdi-frontend-0.10.0',
          '/design_system/static/heroicons-2.1.5',
          '/design_system/static/ndrsuk-frontend-8.1.1',
          '/design_system/static/nhsuk-frontend-9.3.0',
          '/design_system/static/stimulus-3.2.2'
        ],
        root: DesignSystem::Engine.root.join('public')
      )
    end
  end
end
