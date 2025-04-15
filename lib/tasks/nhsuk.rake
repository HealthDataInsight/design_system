require 'fileutils'
require 'pathname'

module NhsukHelpers
  ASSETS_PATH = 'public/design_system/static'.freeze
  STYLESHEET_PATH = 'app/assets/stylesheets/design_system'.freeze
  ENGINE_PATH = 'lib/design_system/engine.rb'.freeze

  def self.versioned_dir(version, brand)
    "#{brand}-frontend-#{version}"
  end

  def self.semantic_version(version)
    "v#{version}"
  end

  def self.remove_existing_versions(brand)
    [ASSETS_PATH, STYLESHEET_PATH].each do |base_path|
      FileUtils.rm_rf(Dir.glob("#{base_path}/#{brand}-frontend-*"))
    end
  end

  def self.update_version_in_file(file_path, version, brand)
    content = File.read(file_path)
    content.gsub!(/#{brand}-frontend-\d+\.\d+\.\d+/, versioned_dir(version, brand))
    File.write(file_path, content)
  end

  def self.validate_version(version, brand)
    return if version&.match(/^\d+\.\d+\.\d+$/)

    raise "Please provide a version number in the format x.x.x (e.g., rake app:make_#{brand}\\[9.3.0\\])"
  end

  def self.setup_directories(version, brand)
    FileUtils.mkdir_p("#{ASSETS_PATH}/#{versioned_dir(version, brand)}")
    FileUtils.mkdir_p("#{STYLESHEET_PATH}/#{versioned_dir(version, brand)}")
  end

  def self.copy_scss_files(temp_dir, version, brand)
    base_path = "#{temp_dir}/node_modules/#{brand}-frontend/packages"
    target_base = "#{STYLESHEET_PATH}/#{versioned_dir(version, brand)}"

    # Copy SCSS files from directories
    %w[components core].each do |dir|
      Dir.glob("#{base_path}/#{dir}/**/*.scss").each do |file|
        relative_path = file.gsub("#{base_path}/", '')
        target_path = "#{target_base}/#{relative_path}"
        FileUtils.mkdir_p(File.dirname(target_path))
        FileUtils.cp(file, target_path)
      end
    end

    # Copy root SCSS files
    FileUtils.cp("#{base_path}/#{brand}.scss", "#{target_base}/#{brand}.scss")
  end

  def self.copy_assets_files(temp_dir, version, brand)
    FileUtils.cp_r(
      "#{temp_dir}/node_modules/#{brand}-frontend/packages/assets/.",
      "#{ASSETS_PATH}/#{versioned_dir(version, brand)}/"
    )
  end

  def self.copy_js_files(temp_dir, version, brand)
    FileUtils.cp(
      "#{temp_dir}/node_modules/#{brand}-frontend/packages/#{brand}.js",
      "#{ASSETS_PATH}/#{versioned_dir(version, brand)}/#{brand}.js"
    )
  end
end

desc 'Update the NHSUK frontend to a specific version'
task :make_nhsuk, [:version] do |_t, args|
  brand = 'nhsuk'

  version = args[:version] || `npm view #{brand}-frontend version`.strip
  NhsukHelpers.validate_version(version, brand)
  NhsukHelpers.remove_existing_versions(brand)

  temp_dir = Dir.mktmpdir("#{brand}-frontend")
  begin
    Dir.chdir(temp_dir) do
      system('npm init -y')
      system("npm install #{brand}-frontend@#{version}")
    end

    NhsukHelpers.setup_directories(version, brand)
    NhsukHelpers.copy_scss_files(temp_dir, version, brand)
    NhsukHelpers.copy_assets_files(temp_dir, version, brand)
    NhsukHelpers.copy_js_files(temp_dir, version, brand)

    NhsukHelpers.update_version_in_file(NhsukHelpers::ENGINE_PATH, version, brand)
    NhsukHelpers.update_version_in_file("#{NhsukHelpers::STYLESHEET_PATH}/#{brand}.scss", version, brand)

    puts "Bumped #{brand.upcase} frontend to #{NhsukHelpers.semantic_version(version)}"
  ensure
    Dir.chdir(Dir.pwd) do
      system("npm uninstall #{brand}-frontend")
      FileUtils.rm_rf(['node_modules', 'package.json', 'package-lock.json'])
    end
    FileUtils.remove_entry_secure(temp_dir)
  end
end
