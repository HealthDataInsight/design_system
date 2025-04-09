desc 'Retrieve a specific version of the NHS design system and generate the NDRS equivalent'
task :nhs2ndrs, [:version] do |t, args|
  require 'fileutils'
  require 'pathname'

  version = args[:version]
  unless version && version.match(/^\d+\.\d+\.\d+$/)
    raise 'Please provide a version number in the format x.x.x (e.g., rake app:nhs2ndrs\[9.3.0\])'
  end

  semantic_version = "v#{version}"

  # Create a temporary directory and clone the repo
  temp_dir = Dir.mktmpdir('ndrsuk-frontend')
  begin
    Dir.chdir(temp_dir) do
      system('git clone https://github.com/HealthDataInsight/ndrsuk-frontend.git .')
      system("./scripts/nhs2ndrs #{semantic_version}")
    end

    assets_path = 'public/design_system/static/'
    stylesheet_path = 'app/assets/stylesheets/design_system/'

    versioned_dir = "ndrsuk-frontend-#{version}"
    FileUtils.mkdir_p("#{assets_path}/#{versioned_dir}")
    FileUtils.mkdir_p("#{stylesheet_path}/#{versioned_dir}")

    # Copy files from ndrsuk-frontend to design_system
    FileUtils.cp(
      "#{temp_dir}/packages/nhsuk.scss",
      "#{stylesheet_path}/#{versioned_dir}/ndrsuk.scss"
    )

    FileUtils.cp_r(
      "#{temp_dir}/packages/components",
      "#{stylesheet_path}/#{versioned_dir}/"
    )

    FileUtils.cp_r(
      "#{temp_dir}/packages/core",
      "#{stylesheet_path}/#{versioned_dir}/"
    )

    FileUtils.cp_r(
      "#{temp_dir}/packages/assets/.",
      "#{assets_path}/#{versioned_dir}/"
    )

    FileUtils.cp(
      "#{temp_dir}/packages/nhsuk.js",
      "#{assets_path}/#{versioned_dir}/ndrsuk.js"
    )

    # Rename files to use NDRS
    ["#{assets_path}/ndrsuk-frontend-#{version}", "#{stylesheet_path}/ndrsuk-frontend-#{version}"].each do |folder|
      Dir.glob("#{folder}/**/*").each do |file|
        next unless File.file?(file)

        next unless file.include?('nhs')

        new_file = file.gsub('nhs', 'ndrs')
        FileUtils.mv(file, new_file)
        file = new_file
      end
    end

    # Update the engine.rb file to use the new version
    engine_path = 'lib/design_system/engine.rb'
    content = File.read(engine_path)
    content.gsub!(/ndrsuk-frontend-\d+\.\d+\.\d+/, "ndrsuk-frontend-#{version}")
    File.write(engine_path, content)

    # Update the ndrsuk.scss file to use the new version
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
    puts "Bumped NDRSUK frontend to #{semantic_version}"
  ensure
    # Clean up the temporary directory
    FileUtils.remove_entry_secure(temp_dir)
  end
end
