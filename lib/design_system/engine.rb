module DesignSystem
  class Engine < ::Rails::Engine
    # Allow changes to the design system to be reloaded in development.
    if Rails.env.development?
      config.autoload_paths << File.expand_path('..', __dir__)
    end
  end
end
