require 'action_dispatch/middleware/remote_ip'
require 'stimulus-rails'

module DesignSystem
  # This is the main engine class for the design system.
  class Engine < ::Rails::Engine
    initializer 'design_system.importmap', before: 'importmap' do |app|
      app.config.importmap.paths << Engine.root.join('config/importmap.rb') if app.config.respond_to?(:importmap)
    end

    # Adding Rack::Static to serve up assets from the design_systems
    initializer 'design_system.add_middleware' do |app|
      app.middleware.insert_after(
        ::ActionDispatch::RemoteIp,
        ::Rack::Static,
        urls: [
          "/design_system/static/design_system-#{DesignSystem::VERSION}",
          '/design_system/static/govuk-frontend-5.11.1',
          '/design_system/static/nhsuk-frontend-9.6.4',
          '/design_system/static/stimulus-3.2.2',
          '/design_system/static/tailwind-4.1.6'
        ],
        root: DesignSystem::Engine.root.join('public')
      )
    end

    # Load the Branded concern before each request (in development) or once (in production)
    config.to_prepare do
      require_dependency Engine.root.join('app/controllers/concerns/design_system/branded.rb').to_s
    end
  end
end
