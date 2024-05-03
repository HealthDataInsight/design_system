module DesignSystem
  class Engine < ::Rails::Engine
    # Allow changes to the design system to be reloaded in development.
    config.autoload_paths << File.expand_path('..', __dir__) if Rails.env.development?
  end
end
