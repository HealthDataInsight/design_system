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
  # Asserts the presence and attributes of a file upload input
  def assert_file_upload(field = nil, type: nil, value: nil, classes: [], attributes: {}, model: 'assistant')
    assert_form_element('input', 'file-upload', field, type:, value:, classes:, attributes:, model:)
  end

  # Assert the presence of a form group
  def assert_form_group(classes = [])
    assert_select('form') do
      form_group = assert_select("div.#{@brand}-form-group#{classes.map { |c| ".#{c}" }.join}").first
      assert form_group, "Form group not found with classes: #{classes.join(', ')}"
      yield(form_group) if block_given?
    end
  end

  # Asserts the presence and attributes of a hint
  def assert_hint(field = nil, text = nil, model: 'assistant')
    selector = "div.#{@brand}-hint[id='#{model}_#{field}_hint']"
    assert_select(selector, text)
  end

  # Asserts the presence and attributes of an input field
  def assert_input(field = nil, type: nil, value: nil, classes: [], attributes: {}, model: 'assistant')
    assert_form_element('input', 'input', field, type:, value:, classes:, attributes:, model:)
  end

  # Asserts the presence and attributes of a label
  # TODO: support special labels like checkbox_label?
  def assert_label(field = nil, text = nil, model: 'assistant', classes: [])
    selector = "label.#{@brand}-label[for='#{model}_#{field}']"
    selector << classes.map { |c| ".#{c}" }.join
    assert_select(selector, text)
  end

  # Asserts the presence and attributes of a text area
  def assert_text_area(field = nil, value: nil, classes: [], attributes: {}, model: 'assistant')
    assert_form_element('textarea', 'textarea', field, value:, classes:, attributes:, model:)
  end

  private

  # Asserts the presence and attributes of a form element
  #
  # @param element_type [Symbol] The type of HTML element to assert (:input, :textarea, :file_upload)
  # @param base_class [String] The class name of the element in the design system, prefixed by the brand name (e.g., 'input', 'textarea', 'file-upload')
  # @param field [Symbol] The form field name (e.g., :title, :description)
  # @param options [Hash] Additional options for the element
  # @option options [String] :type The HTML input type (e.g., 'text', 'email', 'tel')
  # @option options [String] :value The expected value of the field
  # @option options [Array<String>] :classes Additional CSS classes to check for
  # @option options [Hash] :attributes Additional HTML attributes to verify
  # @option options [String] :model The model name for the field (defaults to 'assistant')
  #
  # @example
  #   assert_form_element(:input, :title, type: :text, value: 'Lorem ipsum dolor sit amet')
  #   assert_form_element(:textarea, :description, classes: ['custom-class'])
  #   assert_form_element(:file_upload, :cv, type: :file, attributes: { accept: 'application/pdf' })
  def assert_form_element(element_type, base_class, field, options = {})
    base_classes = ["#{@brand}-#{base_class}"]
    classes = (base_classes + Array(options[:classes])).flatten.compact

    attributes = {
      id: "#{options[:model] || 'assistant'}_#{field}",
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
