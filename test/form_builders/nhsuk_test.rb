require 'test_helper'
require 'design_system/form_builders/nhsuk'
require_relative 'concerns/govuk_form_builder_testable'

module FormBuilders
  class NhsukTest < ActionView::TestCase
    include GovukFormBuilderTestable

    def setup
      @brand = 'nhsuk'
      @builder = DesignSystem::FormBuilders::Nhsuk
    end

    test 'Registry.form_builder returns Nhsuk form builder' do
      assert_equal DesignSystem::FormBuilders::Nhsuk,
                   DesignSystem::Registry.form_builder(@brand)
    end

    test 'ds_hidden_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_hidden_field(:title, value: assistants(:one).title, show_text: 'Show text')
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_label :title, nil, 'Title'
          assert_select("input[class='#{@brand}-u-visually-hidden'][type='hidden'][value='Lorem ipsum dolor sit amet']")
          assert_select("span.#{@brand}-body-m", 'Show text')
        end
      end
    end

    test 'ds_hidden_field with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_hidden_field(:title, value: assistants(:one).title, show_text: 'Show text', class: 'geoff', 'data-foo': 'bar')
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_label :title, nil, 'Title'
          assert_select("input[class='geoff #{@brand}-u-visually-hidden'][type='hidden'][value='Lorem ipsum dolor sit amet'][data-foo=bar]")
          assert_select("span.#{@brand}-body-m", 'Show text')
        end
      end
    end

    test 'ds_password_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_password_field(:title)
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group[data-controller='ds--show-password']") do
          assert_select("label.#{@brand}-label", 'Title')

          input = assert_select('input[type=password]').first
          assert_equal "#{@brand}-input", input['class']
          assert_equal 'current-password', input['autocomplete']
          assert_equal 'password', input['data-ds--show-password-target']
          assert_nil input['value']

          button = assert_select('button[type=button]').first
          assert_equal "#{@brand}-button #{@brand}-button--secondary", button['class']
          assert_equal 'Show password', button['aria-label']
          assert_equal "#{@brand}-button", button['data-module']
          assert_equal 'click->ds--show-password#toggle', button['data-action']
        end
      end
    end

    test 'ds_password_field with error' do
      assistant = Assistant.new
      refute assistant.valid?

      @output_buffer = form_with(model: assistant, builder: @builder) do |f|
        f.ds_password_field(:title)
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group[data-controller='ds--show-password']") do
          assert_select("label.#{@brand}-label", 'Title')

          input = assert_select('input[type=password]').first
          assert_equal "#{@brand}-input #{@brand}-input--error", input['class']
          assert_equal 'current-password', input['autocomplete']
          assert_equal 'password', input['data-ds--show-password-target']
          assert_nil input['value']
        end
      end
    end

    test 'label hidden' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_select(:department_id, options_for_select(Department.all.map { |department| [department.title, department.id] }), label: { hidden: true })
      end

      assert_select("label.#{@brand}-label span.#{@brand}-u-visually-hidden", text: 'What is your department?')
    end

    test 'legend hidden' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_date_field(:date_of_birth, hint: "Demo for ds_date_field", date_of_birth: true, legend: { text:'Find me', size: nil, hidden: true })
      end

      assert_select("legend.#{@brand}-fieldset__legend.#{@brand}-u-visually-hidden", text: 'Find me')
    end
  end
end
