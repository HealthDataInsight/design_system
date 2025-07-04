require 'test_helper'
require 'design_system/form_builders/hdi'
require 'design_system/registry'
require_relative 'concerns/govuk_form_builder_testable'

module FormBuilders
  class HdiTest < ActionView::TestCase
    include GovukFormBuilderTestable

    def setup
      @brand = 'hdi'
      @builder = DesignSystem::FormBuilders::Hdi
    end

    test 'Registry.form_builder returns Hdi form builder' do
      assert_equal DesignSystem::FormBuilders::Hdi,
                   DesignSystem::Registry.form_builder(@brand)
    end

    test 'ds_collection_select without multiple' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_collection_select(:role_id, Role.all, :id, :title, { hint: 'Demo for ds_collection_select', prompt: 'Please select' })
      end

      assert_form_group do
        assert_label :role_id, nil, 'What is your role?'

        select = assert_select("select.#{@brand}-select").first
        assert_equal 'assistant_role_id', select['id']
        assert_equal 'assistant[role_id]', select['name']

        assert_equal 3, Role.all.count
        assert_nil select['style']

        options = assert_select('option')
        assert_equal '1', options[0]['value']
        assert_equal 'User', options[0].text.strip
        assert_equal '2', options[1]['value']
        assert_equal 'Admin', options[1].text.strip
        assert_equal '3', options[2]['value']
        assert_equal 'Super Admin', options[2].text.strip
      end
    end

    test 'ds_collection_select with multiple' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_collection_select(:role_id, Role.all, :id, :title, { hint: 'Demo for ds_collection_select', prompt: 'Please select' }, { multiple: true })
      end

      assert_form_group do
        assert_label :role_id, nil, 'What is your role?'

        select = assert_select("select.#{@brand}-select").first
        assert_equal 'assistant_role_id', select['id']
        assert_equal 'assistant[role_id][]', select['name']

        assert_equal 3, Role.all.count
        assert_equal 'height: 90px;', select['style']

        options = assert_select('option')
        assert_equal '1', options[0]['value']
        assert_equal 'User', options[0].text.strip
        assert_equal '2', options[1]['value']
        assert_equal 'Admin', options[1].text.strip
        assert_equal '3', options[2]['value']
        assert_equal 'Super Admin', options[2].text.strip
      end
    end

    test 'ds_collection_select with prompt and no options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_collection_select(:role_id, [], :id, :title, { hint: 'Demo for ds_collection_select', prompt: 'Please select' })
      end

      assert_form_group do
        assert_label :role_id, nil, 'What is your role?'

        select = assert_select("select.#{@brand}-select").first
        assert_equal 'assistant_role_id', select['id']
        assert_equal 'assistant[role_id]', select['name']

        assert_nil select['style']
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
          assert_includes input['class'], "#{@brand}-input"
          assert_includes input['class'], "#{@brand}-password-field__input"
          assert_equal 'current-password', input['autocomplete']
          assert_equal 'password', input['data-ds--show-password-target']
          assert_nil input['value']

          button = assert_select('button[type=button]').first
          assert_equal "#{@brand}-password-field__button", button['class']
          assert_equal 'Show password', button['aria-label']
          assert_equal "#{@brand}-button", button['data-module']
          assert_equal 'click->ds--show-password#toggle', button['data-action']
          assert_select button, 'svg.password-field__icon'
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
          assert_includes input['class'], "#{@brand}-input"
          assert_includes input['class'], "#{@brand}-password-field__input"
          assert_includes input['class'], "#{@brand}-input--error"
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

      assert_select("label.#{@brand}-label span.#{@brand}-visually-hidden", text: 'What is your department?')
    end

    test 'legend hidden' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_date_field(:date_of_birth, hint: 'Demo for ds_date_field', date_of_birth: true, legend: { text: 'Find me', size: nil, hidden: true })
      end

      assert_select("legend.#{@brand}-fieldset__legend.#{@brand}-visually-hidden", text: 'Find me')
    end
  end
end
