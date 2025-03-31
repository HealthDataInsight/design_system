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
  def assert_form_group(classes = [], &block)
    assert_select('form') do
      form_group = assert_select("div.#{@brand}-form-group#{classes.map { |c| ".#{c}" }.join}").first
      assert form_group, "Form group not found with classes: #{classes.join(', ')}"
      yield(form_group) if block_given?
    end
  end

  def assert_label(field = nil, text = nil, model: 'assistant')
    field = field.to_s.gsub('_', '-')
    selector = "label.#{@brand}-label[for='#{model}-#{field}-field']"
    assert_select(selector, text)
  end

  def assert_hint(field = nil, text = nil, model: 'assistant')
    field = field.to_s.gsub('_', '-')
    selector = "div.#{@brand}-hint[id='#{model}-#{field}-hint']"
    assert_select(selector, text)
  end

  def assert_input(field = nil, type: nil, value: nil, classes: [], attributes: {}, model: 'assistant')
    field = field.to_s.gsub('_', '-')
    input_classes = ["#{@brand}-input"]
    input_classes << classes
    input_classes = input_classes.flatten.compact

    input_attributes = {
      type: type,
      id: "#{model}-#{field}-field",
      name: "#{model}[#{field}]"
    }.merge(attributes)

    # Build the selector with each class as a separate class attribute
    class_selector = input_classes.map { |c| ".#{c}" }.join
    input = assert_select("input#{class_selector}").first
    assert input, "Input not found with classes: #{input_classes.join(', ')}"

    input_attributes.each do |key, expected_value|
      assert_equal expected_value.to_s, input[key.to_s], "Expected #{key} to be '#{expected_value}' but was '#{input[key.to_s]}'"
    end

    assert_equal value, input['value'] if value
  end

  def assert_text_area(field = nil, value: nil, classes: [], attributes: {}, model: 'assistant')
    field = field.to_s.gsub('_', '-')
    textarea_classes = ["#{@brand}-textarea"]
    textarea_classes << classes
    textarea_classes = textarea_classes.flatten.compact

    textarea_attributes = {
      id: "#{model}-#{field}-field",
      name: "#{model}[#{field}]"
    }.merge(attributes)

    class_selector = textarea_classes.map { |c| ".#{c}" }.join
    textarea = assert_select("textarea#{class_selector}").first
    assert textarea, "Textarea not found with classes: #{textarea_classes.join(', ')}"

    textarea_attributes.each do |key, expected_value|
      assert_equal expected_value.to_s, textarea[key.to_s], "Expected #{key} to be '#{expected_value}' but was '#{textarea[key.to_s]}'"
    end

    assert_equal value, textarea['value'] if value
  end
end
