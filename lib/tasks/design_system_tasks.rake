desc 'Retrieve latest version of the NHS design system and generate the NDRS equivalent'
task :nhs2ndrs, [:version] do |t, args|
  require 'fileutils'
  require 'pathname'

  version = args[:version]
  raise 'Please provide a version number (e.g., rake app:nhs2ndrs\[9.3.0\])' unless version

  semantic_version = "v#{version}"

  # Run nhs2ndrs script in the other repo
  other_repo_path = File.expand_path('~/Documents/GitHub/ndrsuk-frontend')

  unless Dir.exist?(other_repo_path)
    parent_dir = File.dirname(other_repo_path)
    FileUtils.mkdir_p(parent_dir)
    Dir.chdir(parent_dir) do
      system('git clone https://github.com/HealthDataInsight/ndrsuk-frontend.git')
    end
  end

  Dir.chdir(other_repo_path) do
    system("./scripts/nhs2ndrs #{semantic_version}")
  end

  assets_path = 'public/design_system/static/'
  stylesheet_path = 'app/assets/stylesheets/design_system/'

  # Create necessary directories
  versioned_dir = "ndrsuk-frontend-#{version}"
  FileUtils.mkdir_p("#{assets_path}/#{versioned_dir}")
  FileUtils.mkdir_p("#{stylesheet_path}/#{versioned_dir}")

  # Copy files from other repo to current repo
  FileUtils.cp(
    "#{other_repo_path}/packages/nhsuk.scss",
    "#{stylesheet_path}/#{versioned_dir}/ndrsuk.scss"
  )

  FileUtils.cp_r(
    "#{other_repo_path}/packages/components",
    "#{stylesheet_path}/#{versioned_dir}/"
  )

  FileUtils.cp_r(
    "#{other_repo_path}/packages/core",
    "#{stylesheet_path}/#{versioned_dir}/"
  )

  FileUtils.cp_r(
    "#{other_repo_path}/packages/assets/.",
    "#{assets_path}/#{versioned_dir}/"
  )

  # Copy min.js
  system('npm install nhsuk-frontend --save')
  min_js_src = 'node_modules/nhsuk-frontend/dist/nhsuk.min.js'
  min_js_dest = "#{assets_path}/#{versioned_dir}/ndrsuk.min.js"
  FileUtils.cp(min_js_src, min_js_dest)

  # file renaming
  ["#{assets_path}/ndrsuk-frontend-#{version}", "#{stylesheet_path}/ndrsuk-frontend-#{version}"].each do |folder|
    Dir.glob("#{folder}/**/*").each do |file|
      next unless File.file?(file)

      next unless file.include?('nhs')

      new_file = file.gsub('nhs', 'ndrs')
      FileUtils.mv(file, new_file)
      file = new_file
    end
  end

  # update the engine.rb file to use the new version
  engine_path = 'lib/design_system/engine.rb'
  content = File.read(engine_path)
  content.gsub!(/ndrsuk-frontend-\d+\.\d+\.\d+/, "ndrsuk-frontend-#{version}")
  File.write(engine_path, content)

  # update the ndrsuk.scss file to use the new version
  ndrsuk_scss_path = "#{stylesheet_path}/ndrsuk.scss"
  content = File.read(ndrsuk_scss_path)
  content.gsub!(/ndrsuk-frontend-\d+\.\d+\.\d+/, "ndrsuk-frontend-#{version}")
  File.write(ndrsuk_scss_path, content)

  # Remove older version ndrs folders
  [assets_path, stylesheet_path].each do |base_path|
    Dir.glob("#{base_path}ndrsuk-frontend-*").each do |dir|
      next unless File.directory?(dir)

      dir_version = dir.match(/ndrsuk-frontend-(\d+\.\d+\.\d+)/)
      next unless dir_version

      dir_version = dir_version[1]
      next if dir_version == version

      FileUtils.rm_rf(dir)
    end
  end

  # Uninstall nhsuk-frontend package
  system('npm uninstall nhsuk-frontend --save')

  puts "Bumped NDRSUK frontend to #{semantic_version}"
end
