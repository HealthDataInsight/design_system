desc 'Retrieve a specific version of the NHS design system and generate the NDRS equivalent'
task :nhs2ndrs, [:version] do |t, args|
  require 'fileutils'
  require 'pathname'

  # Constants
  ASSETS_PATH = 'public/design_system/static/'
  STYLESHEET_PATH = 'app/assets/stylesheets/design_system/'
  ENGINE_PATH = 'lib/design_system/engine.rb'
  NDRSUK_SCSS_PATH = "#{STYLESHEET_PATH}/ndrsuk.scss"

  # Helper methods
  def versioned_dir(version)
    "ndrsuk-frontend-#{version}"
  end

  def semantic_version(version)
    "v#{version}"
  end

  def rename_nhs_to_ndrs(file)
    return unless file.include?('nhs')

    new_file = file.gsub('nhs', 'ndrs')
    FileUtils.mv(file, new_file)
    new_file
  end

  def update_version_in_file(file_path, version)
    content = File.read(file_path)
    content.gsub!(/ndrsuk-frontend-\d+\.\d+\.\d+/, versioned_dir(version))
    File.write(file_path, content)
  end

  # Main task logic
  version = args[:version]
  unless version && version.match(/^\d+\.\d+\.\d+$/)
    raise 'Please provide a version number in the format x.x.x (e.g., rake app:nhs2ndrs\[9.3.0\])'
  end

  # Create a temporary directory and clone the repo
  temp_dir = Dir.mktmpdir('ndrsuk-frontend')
  begin
    Dir.chdir(temp_dir) do
      system('git clone https://github.com/HealthDataInsight/ndrsuk-frontend.git .')
      system("./scripts/nhs2ndrs #{semantic_version(version)}")
    end

    # Create necessary directories
    FileUtils.mkdir_p("#{ASSETS_PATH}/#{versioned_dir(version)}")
    FileUtils.mkdir_p("#{STYLESHEET_PATH}/#{versioned_dir(version)}")

    # Copy files from ndrsuk-frontend to design_system
    FileUtils.cp(
      "#{temp_dir}/packages/nhsuk.scss",
      "#{STYLESHEET_PATH}/#{versioned_dir(version)}/ndrsuk.scss"
    )

    FileUtils.cp_r(
      "#{temp_dir}/packages/components",
      "#{STYLESHEET_PATH}/#{versioned_dir(version)}/"
    )

    FileUtils.cp_r(
      "#{temp_dir}/packages/core",
      "#{STYLESHEET_PATH}/#{versioned_dir(version)}/"
    )

    FileUtils.cp_r(
      "#{temp_dir}/packages/assets/.",
      "#{ASSETS_PATH}/#{versioned_dir(version)}/"
    )

    FileUtils.cp(
      "#{temp_dir}/packages/nhsuk.js",
      "#{ASSETS_PATH}/#{versioned_dir(version)}/ndrsuk.js"
    )

    # Rename files to use NDRS
    [ASSETS_PATH, STYLESHEET_PATH].each do |base_path|
      Dir.glob("#{base_path}#{versioned_dir(version)}/**/*").each do |file|
        next unless File.file?(file)

        rename_nhs_to_ndrs(file)
      end
    end

    # Update version in files
    update_version_in_file(ENGINE_PATH, version)
    update_version_in_file(NDRSUK_SCSS_PATH, version)

    # Remove older version ndrs folders
    [ASSETS_PATH, STYLESHEET_PATH].each do |base_path|
      Dir.glob("#{base_path}ndrsuk-frontend-*").each do |dir|
        next unless File.directory?(dir)

        dir_version = dir.match(/ndrsuk-frontend-(\d+\.\d+\.\d+)/)
        next unless dir_version

        dir_version = dir_version[1]
        next if dir_version == version

        FileUtils.rm_rf(dir)
      end
    end

    puts "Bumped NDRSUK frontend to #{semantic_version(version)}"
  ensure
    # Clean up the temporary directory
    FileUtils.remove_entry_secure(temp_dir)
  end
end
