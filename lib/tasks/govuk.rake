require 'fileutils'
require 'pathname'

module GovukHelpers
  # GOVUK specific constants
  ASSETS_PATH = 'public/design_system/static'
  STYLESHEET_PATH = 'app/assets/stylesheets/design_system'
  ENGINE_PATH = 'lib/design_system/engine.rb'

  def self.versioned_dir(version, brand)
    "#{brand}-frontend-#{version}"
  end

  def self.semantic_version(version)
    "v#{version}"
  end

  def self.remove_existing_versions(brand)
    [ASSETS_PATH, STYLESHEET_PATH].each do |base_path|
      Dir.glob("#{base_path}/#{brand}-frontend-*").each do |dir|
        FileUtils.rm_rf(dir)
      end
    end
  end

  def self.update_version_in_file(file_path, version, brand)
    content = File.read(file_path)
    content.gsub!(/#{brand}-frontend-\d+\.\d+\.\d+/, versioned_dir(version, brand))
    File.write(file_path, content)
  end

  def self.validate_version(version, brand)
    return if version && version.match(/^\d+\.\d+\.\d+$/)

    raise "Please provide a version number in the format x.x.x (e.g., rake app:make_#{brand}\\[9.3.0\\])"
  end

  def self.setup_directories(version, brand)
    FileUtils.mkdir_p("#{ASSETS_PATH}/#{versioned_dir(version, brand)}")
    FileUtils.mkdir_p("#{STYLESHEET_PATH}/#{versioned_dir(version, brand)}")
  end

  def self.copy_scss_files(temp_dir, version, brand)
    # Copy SCSS files
    %w[components core helpers objects overrides settings tools utilities vendor].each do |dir|
      Dir.glob("#{temp_dir}/node_modules/#{brand}-frontend/dist/#{brand}/#{dir}/**/*.scss").each do |file|
        relative_path = file.gsub("#{temp_dir}/node_modules/#{brand}-frontend/dist/#{brand}/", '')
        target_path = "#{STYLESHEET_PATH}/#{versioned_dir(version, brand)}/#{relative_path}"
        FileUtils.mkdir_p(File.dirname(target_path))
        FileUtils.cp(file, target_path)
      end
    end
    %w[_base.scss all.scss].each do |file|
      FileUtils.cp(
        "#{temp_dir}/node_modules/#{brand}-frontend/dist/#{brand}/#{file}",
        "#{STYLESHEET_PATH}/#{versioned_dir(version, brand)}/#{file}"
      )
    end
  end

  def self.copy_assets_files(temp_dir, version, brand)
    # Update assets
    FileUtils.cp_r(
      "#{temp_dir}/node_modules/#{brand}-frontend/dist/#{brand}/assets/.",
      "#{ASSETS_PATH}/#{versioned_dir(version, brand)}/"
    )
  end

  def self.copy_js_files(temp_dir, version, brand)
    # Update JavaScript
    FileUtils.cp(
      "#{temp_dir}/node_modules/#{brand}-frontend/dist/#{brand}/#{brand}-frontend.min.js",
      "#{ASSETS_PATH}/#{versioned_dir(version, brand)}/#{brand}-frontend.min.js"
    )
    FileUtils.cp(
      "#{temp_dir}/node_modules/#{brand}-frontend/dist/#{brand}/#{brand}-frontend.min.js.map",
      "#{ASSETS_PATH}/#{versioned_dir(version, brand)}/#{brand}-frontend.min.js.map"
    )
  end

  def self.remove_source_maps(version, brand)
    Dir.glob("#{STYLESHEET_PATH}/#{versioned_dir(version, brand)}/**/**/*.scss").each do |file|
      content = File.read(file)
      content.gsub!(%r{/\*# sourceMappingURL=.*\.scss\.map \*/\n?}, '')
      content = content.rstrip + "\n"
      File.write(file, content)
    end
  end
end

desc 'Update the GOVUK frontend to a specific version'
task :make_govuk, [:version] do |_t, args|
  version = args[:version]
  brand = 'govuk'
  GovukHelpers.validate_version(version, brand)

  GovukHelpers.remove_existing_versions(brand)

  temp_dir = Dir.mktmpdir("#{brand}-frontend")
  begin
    Dir.chdir(temp_dir) do
      system('npm init -y')
      system("npm install #{brand}-frontend@#{version}")
    end

    GovukHelpers.setup_directories(version, brand)
    GovukHelpers.copy_scss_files(temp_dir, version, brand)
    GovukHelpers.copy_assets_files(temp_dir, version, brand)
    GovukHelpers.copy_js_files(temp_dir, version, brand)

    GovukHelpers.update_version_in_file(GovukHelpers::ENGINE_PATH, version, brand)
    GovukHelpers.update_version_in_file("#{GovukHelpers::STYLESHEET_PATH}/#{brand}.scss", version, brand)

    GovukHelpers.remove_source_maps(version, brand)

    puts "Bumped #{brand.upcase} frontend to #{GovukHelpers.semantic_version(version)}"
  ensure
    # Clean up npm files
    Dir.chdir(Dir.pwd) do
      system("npm uninstall #{brand}-frontend")
      FileUtils.rm_rf('node_modules')
      FileUtils.rm_rf('package.json')
      FileUtils.rm_rf('package-lock.json')
    end
    FileUtils.remove_entry_secure(temp_dir)
  end
end
