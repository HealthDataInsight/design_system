namespace :hdi do
  desc 'Build hdi-frontend and sync assets'
  task :sync do
    hdi_root = File.expand_path('../../../../../hdi-frontend', __dir__)
    version = '0.10.0'
    dest_path = DesignSystem::Engine.root.join("public/design_system/static/hdi-frontend-#{version}")

    puts "🛠️  Building hdi-frontend from #{hdi_root}"
    branch = `cd #{hdi_root} && git rev-parse --abbrev-ref HEAD`.strip
    puts "🌿 Currently on branch: #{branch}"
    sh "cd #{hdi_root} && npm run build"
    # sh "cd #{hdi_root} && npm run build:minify"

    mkdir_p dest_path
    cp "#{hdi_root}/dist/hdi-frontend-#{version}/hdi.css", "#{dest_path}/hdi.scss"
    # cp "#{hdi_root}/dist/hdi-frontend-#{version}/hdi.min.js", "#{dest_path}/hdi.min.js"

    puts '🚀 Precompiling Rails assets'
    sh 'bin/rails assets:clobber'
  end
end
