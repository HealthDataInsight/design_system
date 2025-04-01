if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start 'rails'
  puts 'Required SimpleCov'
end

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require_relative '../test/dummy/config/environment'
ActiveRecord::Migrator.migrations_paths = [File.expand_path('../test/dummy/db/migrate', __dir__)]
require 'rails/test_help'
require 'mocha/minitest'

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_paths=)
  ActiveSupport::TestCase.fixture_paths = [File.expand_path('fixtures', __dir__)]
  ActionDispatch::IntegrationTest.fixture_paths = ActiveSupport::TestCase.fixture_paths
  ActiveSupport::TestCase.file_fixture_path = "#{File.expand_path('fixtures', __dir__)}/files"
  ActiveSupport::TestCase.fixtures :all
end

module GovukFormBuilderTestableHelper
  def assert_form_group(classes = [])
    assert_select('form') do
      form_group = assert_select("div.#{@brand}-form-group#{classes.map { |c| ".#{c}" }.join}").first
      assert form_group, "Form group not found with classes: #{classes.join(', ')}"
      yield(form_group) if block_given?
    end
  end

  def assert_label(field = nil, text = nil, model: 'assistant', classes: [])
    field_for_id = field.to_s.gsub('_', '-')
    selector = "label.#{@brand}-label[for='#{model}-#{field_for_id}-field']"
    selector << classes.map { |c| ".#{c}" }.join
    assert_select(selector, text)
  end

  def assert_legend(text = nil, model: 'assistant', classes: [])
    selector = "legend.#{@brand}-fieldset__legend#{classes.map { |c| ".#{c}" }.join}"
    assert_select(selector, text)
  end

  def assert_hint(field = nil, text = nil, model: 'assistant')
    field_for_id = field.to_s.gsub('_', '-')
    selector = "div.#{@brand}-hint[id='#{model}-#{field_for_id}-hint']"
    assert_select(selector, text)
  end

  def assert_input(field = nil, type: nil, value: nil, classes: [], attributes: {}, model: 'assistant')
    assert_form_element('input', 'input', field, type:, value:, classes:, attributes:, model:)
  end

  def assert_text_area(field = nil, value: nil, classes: [], attributes: {}, model: 'assistant')
    assert_form_element('textarea', 'textarea', field, value:, classes:, attributes:, model:)
  end

  def assert_file_upload(field = nil, type: nil, value: nil, classes: [], attributes: {}, model: 'assistant')
    assert_form_element('input', 'file-upload', field, type:, value:, classes:, attributes:, model:)
  end

  private

  def assert_form_element(element_type, base_class, field, options = {})
    field_for_id = field.to_s.gsub('_', '-')
    base_classes = ["#{@brand}-#{base_class}"]
    classes = (base_classes + Array(options[:classes])).flatten.compact

    attributes = {
      id: "#{options[:model] || 'assistant'}-#{field_for_id}-field",
      name: "#{options[:model] || 'assistant'}[#{field}]"
    }.merge(options[:attributes] || {})

    # Build the selector with each class as a separate class attribute
    class_selector = classes.map { |c| ".#{c}" }.join
    element = assert_select("#{element_type}#{class_selector}").first
    assert element, "#{element_type.capitalize} not found with type: #{options[:type]} and classes: #{classes.join(', ')}"

    attributes.each do |key, expected_value|
      assert_equal expected_value.to_s, element[key.to_s], "Expected #{key} to be '#{expected_value}' but was '#{element[key.to_s]}'"
    end

    assert_equal options[:value], element['value'] if options[:value]
  end
end
