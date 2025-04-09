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
    "#{other_repo_path}/packages/assets/",
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

# task :retrieve_nhsuk_ds, [:version] do |_t, args|
#   require 'fileutils'
#   require 'pathname'

#   # Install nhsuk-frontend package
#   system('npm install nhsuk-frontend --save')

#   # Get the installed version from package.json
#   package_json = JSON.parse(File.read('package.json'))
#   version = args[:version] || package_json['dependencies']['nhsuk-frontend'].gsub('^', '')

#   # Define source and destination paths
#   FOLDERS = [
#     { src: 'node_modules/nhsuk-frontend/packages/assets',
#       dest: "public/design_system/static/nhsuk-frontend-#{version}" },
#     { src: 'node_modules/nhsuk-frontend/packages/components',
#       dest: "app/assets/stylesheets/design_system/nhsuk-frontend-#{version}/components" },
#     { src: 'node_modules/nhsuk-frontend/packages/core',
#       dest: "app/assets/stylesheets/design_system/nhsuk-frontend-#{version}/core" },
#     { src: 'node_modules/nhsuk-frontend/packages',
#       dest: "app/assets/stylesheets/design_system/nhsuk-frontend-#{version}/packages" }
#   ].freeze

#   # Create destination directories if they don't exist
#   FOLDERS.each do |folder|
#     FileUtils.mkdir_p(folder[:dest])
#   end

#   # Copy assets
#   FOLDERS.each do |folder|
#     FileUtils.rm_rf(folder[:dest]) if Dir.exist?(folder[:dest])
#     FileUtils.cp_r(folder[:src], folder[:dest])
#   end

#   # Remove all README.md files from assets directory
#   FOLDERS.each do |folder|
#     Dir.glob(File.join(folder[:dest], '**', 'README.md')).each do |readme_file|
#       FileUtils.rm(readme_file) if File.exist?(readme_file)
#     end
#   end

#   # Remove all .njk files from assets directory
#   FOLDERS.each do |folder|
#     Dir.glob(File.join(folder[:dest], '**', '*.njk')).each do |njk_file|
#       FileUtils.rm(njk_file) if File.exist?(njk_file)
#     end
#   end

#   # Copy nhsuk.min.js
#   min_js_src = 'node_modules/nhsuk-frontend/dist/nhsuk.min.js'
#   min_js_dest = "#{FOLDERS[0][:dest]}/nhsuk.min.js"
#   FileUtils.cp(min_js_src, min_js_dest)
#   FileUtils.rm(min_js_src) if File.exist?(min_js_src)

#   # Copy nhsuk.scss
#   scss_src = 'node_modules/nhsuk-frontend/packages/nhsuk.scss'
#   scss_dest = "#{FOLDERS[1][:dest]}/nhsuk.scss"
#   FileUtils.cp(scss_src, scss_dest)
#   FileUtils.rm(scss_src) if File.exist?(scss_src)

#   # Clean up source directories after copying
#   FOLDERS.each do |folder|
#     FileUtils.rm_rf(folder[:src]) if Dir.exist?(folder[:src])
#   end

#   # Uninstall nhsuk-frontend package
#   system('npm uninstall nhsuk-frontend --save')

#   puts "Successfully retrieved NHS UK frontend version #{version}"
# end

# task :make_ndrs_ds do
#   require 'fileutils'
#   require 'pathname'

#   # Find the latest NHS UK frontend version
#   version = Dir.glob('public/design_system/static/nhsuk-frontend-*')
#                .map { |d| d.match(/nhsuk-frontend-(\d+\.\d+\.\d+)/)[1] }
#                .max_by { |v| Gem::Version.new(v) }

#   puts "Found NHS UK frontend version: #{version}"

#   # Define source and destination paths
#   FOLDERS = [
#     { src: "public/design_system/static/nhsuk-frontend-#{version}",
#       dest: "public/design_system/static/ndrsuk-frontend-#{version}" },
#     { src: "app/assets/stylesheets/design_system/nhsuk-frontend-#{version}",
#       dest: "app/assets/stylesheets/design_system/ndrsuk-frontend-#{version}" },
#     { src: "app/assets/stylesheets/nhsuk-frontend-#{version}",
#       dest: "app/assets/stylesheets/ndrsuk-frontend-#{version}" }
#   ].freeze

#   # Copy files
#   puts 'Copy content from NHSUK frontend to NDRS frontend'
#   FOLDERS.each do |folder|
#     FileUtils.rm_rf(folder[:dest]) if Dir.exist?(folder[:dest])
#     FileUtils.cp_r(folder[:src], folder[:dest])
#   end

#   # Update ndrsuk.scss
#   puts 'Updating ndrsuk.scss'
#   ndrsuk_scss_path = 'app/assets/stylesheets/design_system/ndrsuk.scss'
#   content = File.read(ndrsuk_scss_path)
#   content.gsub!(/ndrsuk-frontend-\d+\.\d+\.\d+/, "ndrsuk-frontend-#{version}")
#   File.write(ndrsuk_scss_path, content)

#   # Update engine.rb
#   puts 'Updating engine.rb'
#   engine_path = 'lib/design_system/engine.rb'
#   content = File.read(engine_path)
#   content.gsub!(/ndrsuk-frontend-\d+\.\d+\.\d+/, "ndrsuk-frontend-#{version}")
#   File.write(engine_path, content)

#   # Remove older version ndrs folders
#   base_dirs = [
#     'public/design_system/static/',
#     'app/assets/stylesheets/design_system/',
#     'app/assets/stylesheets/'
#   ]

#   base_dirs.each do |base_dir|
#     Dir.glob("#{base_dir}ndrsuk-frontend-*").each do |dir|
#       dir_version = dir.match(/ndrsuk-frontend-(\d+\.\d+\.\d+)/)[1]
#       next if dir_version == version

#       puts "Removing old version: #{dir}"
#       FileUtils.rm_rf(dir)
#     end
#   end

#   # Replace NHS with NDRS in the new folders
#   puts 'Replacing NHS with NDRS in new folders'
#   FOLDERS.each do |folder|
#     Dir.glob("#{folder[:dest]}/**/*").each do |file|
#       next unless File.file?(file)

#       next unless file.include?('nhs')

#       new_file = file.gsub('nhs', 'ndrs')
#       FileUtils.mv(file, new_file)
#       file = new_file
#     end

#     Dir.glob("#{folder[:dest]}/**/*").each do |file|
#       next unless File.file?(file)

#       content = File.read(file)
#       content.gsub!('nhs', 'ndrs')
#       content.gsub!('NHS', 'NDRS')
#       File.write(file, content)
#     end
#   end

#   puts 'Design system update completed successfully!'
# end
