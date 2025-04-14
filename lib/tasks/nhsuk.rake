require 'fileutils'
require 'pathname'

# Shared constants
ASSETS_PATH = 'public/design_system/static'
STYLESHEET_PATH = 'app/assets/stylesheets/design_system'
ENGINE_PATH = 'lib/design_system/engine.rb'

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

def remove_js_files(version, brand)
  Dir.glob("#{STYLESHEET_PATH}/#{versioned_dir(version, brand)}/**/**/*.js").each do |file|
    FileUtils.rm_rf(file)
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

  raise "Please provide a version number in the format x.x.x (e.g., rake app:make_#{brand}\\[9.3.0\\])"
end

def setup_directories(version, brand)
  FileUtils.mkdir_p("#{ASSETS_PATH}/#{versioned_dir(version, brand)}")
  FileUtils.mkdir_p("#{STYLESHEET_PATH}/#{versioned_dir(version, brand)}")
end

def copy_files_from_repo(temp_dir, version, brand)
  # Update SCSS files
  FileUtils.cp(
    "#{temp_dir}/node_modules/#{brand}-frontend/packages/#{brand}.scss",
    "#{STYLESHEET_PATH}/#{versioned_dir(version, brand)}/#{brand}.scss"
  )

  # Update components and core
  %w[components core].each do |dir|
    FileUtils.cp_r(
      "#{temp_dir}/node_modules/#{brand}-frontend/packages/#{dir}",
      "#{STYLESHEET_PATH}/#{versioned_dir(version, brand)}/"
    )
  end

  # Update assets
  FileUtils.cp_r(
    "#{temp_dir}/node_modules/#{brand}-frontend/packages/assets/.",
    "#{ASSETS_PATH}/#{versioned_dir(version, brand)}/"
  )

  # Update JavaScript
  FileUtils.cp(
    "#{temp_dir}/node_modules/#{brand}-frontend/packages/#{brand}.js",
    "#{ASSETS_PATH}/#{versioned_dir(version, brand)}/#{brand}.js"
  )
end

desc 'Update the NHS frontend to a specific version'
task :make_nhsuk, [:version] do |_t, args|
  version = args[:version]
  brand = 'nhsuk'
  validate_version(version, brand)

  remove_existing_versions(brand)

  temp_dir = Dir.mktmpdir("#{brand}-frontend")
  begin
    Dir.chdir(temp_dir) do
      system('npm init -y')
      system("npm install #{brand}-frontend@#{version}")
    end

    setup_directories(version, brand)
    copy_files_from_repo(temp_dir, version, brand)

    update_version_in_file(ENGINE_PATH, version, brand)
    update_version_in_file("#{STYLESHEET_PATH}/#{brand}.scss", version, brand)

    remove_markdown_files(version, brand)
    remove_njk_files(version, brand)
    remove_js_files(version, brand)

    puts "Bumped #{brand.upcase} frontend to #{semantic_version(version)}"
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
