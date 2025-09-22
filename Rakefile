require "bundler/setup"

APP_RAKEFILE = File.expand_path("test/dummy/Rakefile", __dir__)
load "rails/tasks/engine.rake"

load "rails/tasks/statistics.rake"

require "bundler/gem_tasks"
require 'ndr_dev_support/tasks'

# This class is responsible for building the JavaScript for the design system.
class JsBuilder
  extend Rake::FileUtilsExt

  def self.build(watch: false)
    require 'fileutils'

    sh 'npm install'

    # Remove all old builds
    FileUtils.rm_rf(Dir.glob('public/design_system/static/design_system-*'))

    output_dir = "public/design_system/static/design_system-#{DesignSystem::VERSION}"
    mkdir_p(output_dir)

    command = 'npx esbuild app/javascript/design_system/index.js --bundle ' \
              "--outfile=#{output_dir}/design_system.js --format=esm"
    command += " --watch" if watch

    if watch
      puts "Watching for changes... Press Ctrl+C to stop"
      trap('INT') do
        puts "\nStopping watch mode"
        exit
      end
    end

    sh command
  end
end

namespace :js do
  desc 'Build the JavaScript for the design system'
  task :build do
    JsBuilder.build(watch: false)
  end

  desc 'Watch for changes and rebuild the JavaScript for the design system'
  task :watch do
    JsBuilder.build(watch: true)
  end
end
