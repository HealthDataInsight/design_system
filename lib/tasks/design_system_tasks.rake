desc 'Retrieve latest version of the NHS design system and generate the NDRS equivalent'
task :make_ndrs_ds do
  require 'fileutils'
  require 'pathname'

  # Find the latest NHS UK frontend version
  version = Dir.glob('public/design_system/static/nhsuk-frontend-*').
            map { |d| d.match(/nhsuk-frontend-(\d+\.\d+\.\d+)/)[1] }.
            max_by { |v| Gem::Version.new(v) }

  puts "Found NHS UK frontend version: #{version}"

  # Define source and destination paths
  FOLDERS = [
    { src: "public/design_system/static/nhsuk-frontend-#{version}",
      dest: "public/design_system/static/ndrsuk-frontend-#{version}" },
    { src: "app/assets/stylesheets/design_system/nhsuk-frontend-#{version}",
      dest: "app/assets/stylesheets/design_system/ndrsuk-frontend-#{version}" },
    { src: "app/assets/stylesheets/nhsuk-frontend-#{version}",
      dest: "app/assets/stylesheets/ndrsuk-frontend-#{version}" }
  ].freeze

  # Copy files
  puts 'Copy content from NHSUK frontend to NDRS frontend'
  FOLDERS.each do |folder|
    FileUtils.rm_rf(folder[:dest]) if Dir.exist?(folder[:dest])
    FileUtils.cp_r(folder[:src], folder[:dest])
  end

  # Update ndrsuk.scss
  puts 'Updating ndrsuk.scss'
  ndrsuk_scss_path = 'app/assets/stylesheets/design_system/ndrsuk.scss'
  content = File.read(ndrsuk_scss_path)
  content.gsub!(/ndrsuk-frontend-\d+\.\d+\.\d+/, "ndrsuk-frontend-#{version}")
  File.write(ndrsuk_scss_path, content)

  # Update engine.rb
  puts 'Updating engine.rb'
  engine_path = 'lib/design_system/engine.rb'
  content = File.read(engine_path)
  content.gsub!(/ndrsuk-frontend-\d+\.\d+\.\d+/, "ndrsuk-frontend-#{version}")
  File.write(engine_path, content)

  # Remove older version ndrs folders
  base_dirs = [
    'public/design_system/static/',
    'app/assets/stylesheets/design_system/',
    'app/assets/stylesheets/'
  ]

  base_dirs.each do |base_dir|
    Dir.glob("#{base_dir}ndrsuk-frontend-*").each do |dir|
      dir_version = dir.match(/ndrsuk-frontend-(\d+\.\d+\.\d+)/)[1]
      next if dir_version == version

      puts "Removing old version: #{dir}"
      FileUtils.rm_rf(dir)
    end
  end

  # Replace NHS with NDRS in the new folders
  puts 'Replacing NHS with NDRS in new folders'
  FOLDERS.each do |folder|
    Dir.glob("#{folder[:dest]}/**/*").each do |file|
      next unless File.file?(file)

      next unless file.include?('nhs')

      new_file = file.gsub('nhs', 'ndrs')
      FileUtils.mv(file, new_file)
      file = new_file
    end

    Dir.glob("#{folder[:dest]}/**/*").each do |file|
      next unless File.file?(file)

      content = File.read(file)
      content.gsub!('nhs', 'ndrs')
      content.gsub!('NHS', 'NDRS')
      File.write(file, content)
    end
  end

  # Update color values in _colours.scss files
  puts 'Updating color values in _colours.scss files'
  FOLDERS.each do |folder|
    colours_file = File.join(folder[:dest], 'core/settings/_colours.scss')
    next unless File.exist?(colours_file)

    content = File.read(colours_file)
    content.gsub!('$color_ndrsuk-blue: #005eb8;', '$color_ndrsuk-blue: #218183;')

    File.write(colours_file, content)
  end

  puts 'Design system update completed successfully!'
end
