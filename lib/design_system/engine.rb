require 'action_dispatch/middleware/remote_ip'

module DesignSystem
  # This is the main engine class for the design system.
  class Engine < ::Rails::Engine
    # Allow changes to the design system to be reloaded in development.
    config.autoload_paths << File.expand_path('..', __dir__) if Rails.env.development?

    # Adding Rack::Static to serve up assets from the design_systems
    initializer 'design_system.add_middleware' do |app|
      app.middleware.insert_after(
        ::ActionDispatch::RemoteIp,
        ::Rack::Static,
        urls: [
          '/design_system/flowbite-2.5.1',
          '/design_system/govuk-frontend-5.3.1',
          '/design_system/ndrsuk-frontend-8.1.1',
          '/design_system/nhsuk-frontend-9.1.0'
        ],
        root: DesignSystem::Engine.root.join('public')
      )
    end
  end
end
