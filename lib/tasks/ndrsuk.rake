require 'fileutils'
require 'pathname'

module NdrsukHelpers
  ASSETS_PATH = 'public/design_system/static'.freeze
  STYLESHEET_PATH = 'app/assets/stylesheets/design_system'.freeze
  ENGINE_PATH = 'lib/design_system/engine.rb'.freeze
  APPLICATION_LAYOUT_PATH = 'app/views/layouts/ndrsuk/application.html.erb'.freeze

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
    return if version&.match(/^\d+\.\d+\.\d+$/)

    raise "Please provide a version number in the format x.x.x (e.g., rake app:make_#{brand}\\[9.3.0\\])"
  end

  def self.setup_directories(version, brand)
    FileUtils.mkdir_p("#{ASSETS_PATH}/#{versioned_dir(version, brand)}")
    FileUtils.mkdir_p("#{STYLESHEET_PATH}/#{versioned_dir(version, brand)}")
  end

  def self.copy_scss_files(temp_dir, version, brand)
    # Update components and core
    %w[components core].each do |dir|
      Dir.glob("#{temp_dir}/packages/#{dir}/**/*.scss").each do |file|
        relative_path = file.gsub("#{temp_dir}/packages/", '')
        target_path = "#{STYLESHEET_PATH}/#{versioned_dir(version, brand)}/#{relative_path}"
        FileUtils.mkdir_p(File.dirname(target_path))
        FileUtils.cp(file, target_path)
      end
    end

    # Update root SCSS files
    FileUtils.cp(
      "#{temp_dir}/packages/#{brand}.scss",
      "#{STYLESHEET_PATH}/#{versioned_dir(version, brand)}/#{brand}.scss"
    )
  end

  def self.copy_assets_files(temp_dir, version, brand)
    FileUtils.cp_r(
      "#{temp_dir}/packages/assets/.",
      "#{ASSETS_PATH}/#{versioned_dir(version, brand)}/"
    )
  end

  def self.copy_js_files(temp_dir, version, brand)
    FileUtils.cp(
      "#{temp_dir}/packages/#{brand}.js",
      "#{ASSETS_PATH}/#{versioned_dir(version, brand)}/#{brand}.js"
    )
    FileUtils.cp(
      "#{temp_dir}/packages/#{brand}.min.js",
      "#{ASSETS_PATH}/#{versioned_dir(version, brand)}/#{brand}.min.js"
    )
  end
end

desc 'Retrieve a specific version of the NHSUK design system and generate the NDRSUK equivalent'
task :make_ndrsuk, [:version] do |_t, args|
  brand = 'ndrsuk'

  version = args[:version]
  NdrsukHelpers.validate_version(version, brand)
  NdrsukHelpers.remove_existing_versions(brand)

  temp_dir = Dir.mktmpdir("#{brand}-frontend")
  puts "temp_dir: #{temp_dir}"
  begin
    Dir.chdir(temp_dir) do
      system('git clone https://github.com/HealthDataInsight/ndrsuk-frontend.git .')
      system("./scripts/nhs2ndrs #{NdrsukHelpers.semantic_version(version)}")
    end

    NdrsukHelpers.setup_directories(version, brand)
    NdrsukHelpers.copy_scss_files(temp_dir, version, brand)
    NdrsukHelpers.copy_assets_files(temp_dir, version, brand)
    NdrsukHelpers.copy_js_files(temp_dir, version, brand)

    NdrsukHelpers.update_version_in_file(NdrsukHelpers::APPLICATION_LAYOUT_PATH, version, brand)
    NdrsukHelpers.update_version_in_file(NdrsukHelpers::ENGINE_PATH, version, brand)
    NdrsukHelpers.update_version_in_file("#{NdrsukHelpers::STYLESHEET_PATH}/#{brand}.scss", version, brand)

    puts "Bumped #{brand.upcase} frontend to #{NdrsukHelpers.semantic_version(version)}"
  ensure
    FileUtils.remove_entry_secure(temp_dir)
  end
end
