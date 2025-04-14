require 'fileutils'
require 'pathname'

# Shared constants
ASSETS_PATH = 'public/design_system/static'
STYLESHEET_PATH = 'app/assets/stylesheets/design_system'
ENGINE_PATH = 'lib/design_system/engine.rb'

# Shared helper methods
def versioned_dir(version, brand)
  "#{brand}-frontend-#{version}"
end

def semantic_version(version)
  "v#{version}"
end

def remove_markdown_files(version, brand)
  [ASSETS_PATH, STYLESHEET_PATH].each do |dir|
    Dir.glob("#{dir}/#{versioned_dir(version, brand)}/**/*.md").each do |file|
      FileUtils.rm_rf(file)
    end
  end
end

def remove_njk_files(version, brand)
  [ASSETS_PATH, STYLESHEET_PATH].each do |dir|
    Dir.glob("#{dir}/#{versioned_dir(version, brand)}/**/*.njk").each do |file|
      FileUtils.rm_rf(file)
    end
  end
end

def remove_existing_versions(brand)
  [ASSETS_PATH, STYLESHEET_PATH].each do |base_path|
    Dir.glob("#{base_path}/#{brand}-frontend-*").each do |dir|
      FileUtils.rm_rf(dir)
    end
  end
end

def update_version_in_file(file_path, version, brand)
  content = File.read(file_path)
  content.gsub!(/#{brand}-frontend-\d+\.\d+\.\d+/, versioned_dir(version, brand))
  File.write(file_path, content)
end

def validate_version(version, brand)
  return if version && version.match(/^\d+\.\d+\.\d+$/)

  raise "Please provide a version number in the format x.x.x (e.g., rake app:update_#{brand}_frontend\\[9.3.0\\])"
end

def setup_directories(version, brand)
  FileUtils.mkdir_p("#{ASSETS_PATH}/#{versioned_dir(version, brand)}")
  FileUtils.mkdir_p("#{STYLESHEET_PATH}/#{versioned_dir(version, brand)}")
end

def copy_files_from_repo(temp_dir, version, brand)
  # Update SCSS files
  FileUtils.cp(
    "#{temp_dir}/packages/nhsuk.scss",
    "#{STYLESHEET_PATH}/#{versioned_dir(version, brand)}/#{brand}.scss"
  )

  # Update components and core
  %w[components core].each do |dir|
    FileUtils.cp_r(
      "#{temp_dir}/packages/#{dir}",
      "#{STYLESHEET_PATH}/#{versioned_dir(version, brand)}/"
    )
  end

  # Update assets
  FileUtils.cp_r(
    "#{temp_dir}/packages/assets/.",
    "#{ASSETS_PATH}/#{versioned_dir(version, brand)}/"
  )

  # Update JavaScript
  FileUtils.cp(
    "#{temp_dir}/packages/nhsuk.js",
    "#{ASSETS_PATH}/#{versioned_dir(version, brand)}/#{brand}.js"
  )
end

desc 'Update the NHS frontend to a specific version'
task :update_nhs_frontend, [:version] do |_t, args|
  version = args[:version]
  validate_version(version, 'nhs')
  brand = 'nhsuk'

  remove_existing_versions(brand)

  temp_dir = Dir.mktmpdir("#{brand}-frontend")
  begin
    Dir.chdir(temp_dir) do
      system('git clone https://github.com/nhsuk/nhsuk-frontend.git .')
    end

    setup_directories(version, brand)
    copy_files_from_repo(temp_dir, version, brand)

    update_version_in_file(ENGINE_PATH, version, brand)
    update_version_in_file("#{STYLESHEET_PATH}/#{brand}.scss", version, brand)

    remove_markdown_files(version, brand)
    remove_njk_files(version, brand)

    puts "Bumped #{brand.upcase}UK frontend to #{semantic_version(version)}"
  ensure
    FileUtils.remove_entry_secure(temp_dir)
  end
end

desc 'Retrieve a specific version of the NHS design system and generate the NDRS equivalent'
task :update_ndrs_frontend, [:version] do |_t, args|
  version = args[:version]
  validate_version(version, 'ndrs')
  brand = 'ndrsuk'

  remove_existing_versions(brand)

  temp_dir = Dir.mktmpdir("#{brand}-frontend")
  puts "temp_dir: #{temp_dir}"
  begin
    Dir.chdir(temp_dir) do
      system('git clone https://github.com/HealthDataInsight/ndrsuk-frontend.git .')
      system("./scripts/nhs2ndrs #{semantic_version(version)}")
    end

    setup_directories(version, brand)
    copy_files_from_repo(temp_dir, version, brand)

    update_version_in_file(ENGINE_PATH, version, brand)
    update_version_in_file("#{STYLESHEET_PATH}/#{brand}.scss", version, brand)

    remove_markdown_files(version, brand)
    remove_njk_files(version, brand)

    puts "Bumped #{brand.upcase}UK frontend to #{semantic_version(version)}"
  ensure
    FileUtils.remove_entry_secure(temp_dir)
  end
end
