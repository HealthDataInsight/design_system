require 'sprockets/rails/quiet_assets'

module DesignSystem
  class Engine < ::Rails::Engine
    # Allow changes to the design system to be reloaded in development.
    config.autoload_paths << File.expand_path('..', __dir__) if Rails.env.development?

    # Adding Rack::Static to serve up assets from the design_systems
    initializer 'design_system.add_middleware' do |app|
      app.middleware.insert_before(
        ::Sprockets::Rails::QuietAssets,
        ::Rack::Static,
        urls: ['/design_system'],
        root: DesignSystem::Engine.root.join('public')
      )
    end
  end
end
