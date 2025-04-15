require 'fileutils'
require 'pathname'

module GovukHelpers
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
    return if version&.match?(/^\d+\.\d+\.\d+$/)

    raise "Please provide a version number in the format x.x.x (e.g., rake app:make_#{brand}\\[5.9.0\\])"
  end

  def self.setup_directories(version, brand)
    [ASSETS_PATH, STYLESHEET_PATH].each do |path|
      FileUtils.mkdir_p("#{path}/#{versioned_dir(version, brand)}")
    end
  end

  def self.copy_scss_files(temp_dir, version, brand)
    base_path = "#{temp_dir}/node_modules/#{brand}-frontend/dist/#{brand}"
    target_base = "#{STYLESHEET_PATH}/#{versioned_dir(version, brand)}"

    # Copy SCSS files from directories
    %w[components core helpers objects overrides settings tools utilities vendor].each do |dir|
      Dir.glob("#{base_path}/#{dir}/**/*.scss").each do |file|
        relative_path = file.gsub("#{base_path}/", '')
        target_path = "#{target_base}/#{relative_path}"
        FileUtils.mkdir_p(File.dirname(target_path))
        FileUtils.cp(file, target_path)
      end
    end

    # Copy root SCSS files
    %w[_base.scss all.scss].each do |file|
      FileUtils.cp("#{base_path}/#{file}", "#{target_base}/#{file}")
    end
  end

  def self.copy_assets_files(temp_dir, version, brand)
    FileUtils.cp_r(
      "#{temp_dir}/node_modules/#{brand}-frontend/dist/#{brand}/assets/.",
      "#{ASSETS_PATH}/#{versioned_dir(version, brand)}/"
    )
  end

  def self.copy_js_files(temp_dir, version, brand)
    base_path = "#{temp_dir}/node_modules/#{brand}-frontend/dist/#{brand}"
    target_base = "#{ASSETS_PATH}/#{versioned_dir(version, brand)}"

    %w[.min.js .min.js.map].each do |ext|
      FileUtils.cp(
        "#{base_path}/#{brand}-frontend#{ext}",
        "#{target_base}/#{brand}-frontend#{ext}"
      )
    end
  end

  def self.remove_source_maps(version, brand)
    Dir.glob("#{STYLESHEET_PATH}/#{versioned_dir(version, brand)}/**/**/*.scss").each do |file|
      content = File.read(file)
      content.gsub!(%r{/\*# sourceMappingURL=.*\.scss\.map \*/\n?}, '')
      content = "#{content.rstrip}\n"
      File.write(file, content)
    end
  end
end

desc 'Update the GOVUK frontend to a specific version'
task :make_govuk, [:version] do |_t, args|
  brand = 'govuk'

  version = args[:version] || `npm view #{brand}-frontend version`.strip
  GovukHelpers.validate_version(version, brand)
  GovukHelpers.remove_existing_versions(brand)

  temp_dir = Dir.mktmpdir("#{brand}-frontend")
  begin
    Dir.chdir(temp_dir) do
      system('npm init -y')
      system("npm install #{brand}-frontend#{version ? "@#{version}" : ''}")
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
    Dir.chdir(Dir.pwd) do
      system("npm uninstall #{brand}-frontend")
      FileUtils.rm_rf(['node_modules', 'package.json', 'package-lock.json'])
    end
    FileUtils.remove_entry_secure(temp_dir)
  end
end
