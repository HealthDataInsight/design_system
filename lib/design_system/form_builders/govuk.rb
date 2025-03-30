require_relative 'base'
require 'govuk_design_system_formbuilder'

module DesignSystem
  # Module namespace containing all the form builders
  module FormBuilders
    # The Govuk version of the form builder
    class Govuk < Base
      include GOVUKDesignSystemFormBuilder::Builder

      def initialize(object_name, object, template, options)
        super

        config.brand = self.class.brand
      end

      # This builder provider the following helper methods:
      # ds_file_field
      # ds_label
      # ds_password_field
      # ds_text_area
      # ds_text_field

      # Same interface as ActionView::Helpers::FormHelper.label
      def ds_label(method, content_or_options = nil, options = nil, &)
        content, options = separate_content_or_options(content_or_options, options)
        text = content || translated_label(method)

        # size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
        # tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
        # hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
        # kwargs [Hash] additional arguments are applied as attributes on the +label+ element
        govuk_label(method, text:, size: nil, hidden: false, tag: nil, caption: nil, **options)
      end

      # Same interface as ActionView::Helpers::FormHelper.text_field, but with label automatically added.
      def ds_text_field(method, options = {})
        label = { size: nil, text: translated_label(method) }
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        # width [Integer,String] sets the width of the input, can be +2+, +3+ +4+, +5+, +10+ or +20+ characters
        #   or +one-quarter+, +one-third+, +one-half+, +two-thirds+ or +full+ width of the container
        # extra_letter_spacing [Boolean] when true adds space between characters to increase the readability of
        #   sequences of letters and numbers. Defaults to +false+.
        # caption [Hash] configures or sets the caption content which is inserted above the label
        # caption text [String] the caption text
        # caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
        # caption kwargs [Hash] additional arguments are applied as attributes on the caption +span+ element
        # form_group [Hash] configures the form group
        # form_group kwargs [Hash] additional attributes added to the form group
        # prefix_text [String] the text placed before the input. No prefix will be added if left +nil+
        # suffix_text [String] the text placed after the input. No suffix will be added if left +nil+
        # block [Block] arbitrary HTML that will be rendered between the hint and the input
        govuk_text_field(method, hint:, label:, caption: {}, width: nil, extra_letter_spacing: false,
                                 form_group: {}, prefix_text: nil, suffix_text: nil, **options)
      end

      def ds_phone_field(method, options = {})
        label = options.delete(:label)
        label = { size: nil, text: label || translated_label(method) }
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        govuk_phone_field(method, hint:, label:, caption: {}, width: nil, extra_letter_spacing: false, form_group: {},
                                  prefix_text: nil, suffix_text: nil, **options)
      end

      def ds_email_field(method, options = {})
        label = options.delete(:label)
        label = { size: nil, text: label || translated_label(method) }
        hint = options.delete(:hint)
        hint = { text: hint } if hint
        govuk_email_field(method, hint:, label:, caption: {}, width: nil, extra_letter_spacing: false, form_group: {},
                                  prefix_text: nil, suffix_text: nil, **options)
      end

      def ds_url_field(method, options = {})
        label = options.delete(:label)
        label = { size: nil, text: label || translated_label(method) }
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        govuk_url_field(method, hint:, label:, caption: {}, width: nil, extra_letter_spacing: false, form_group: {},
                                prefix_text: nil, suffix_text: nil, **options)
      end

      def ds_number_field(method, options = {})
        label = options.delete(:label)
        label = { size: nil, text: label || translated_label(method) }
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        govuk_number_field(method, hint:, label:, caption: {}, width: nil, extra_letter_spacing: false, form_group: {},
                                   prefix_text: nil, suffix_text: nil, **options)
      end

      # Same interface as ActionView::Helpers::FormHelper.password_field, but with label automatically added.
      def ds_password_field(method, options = {})
        label = options.delete(:label)
        label = { size: nil, text: label || translated_label(method) }
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        # caption [Hash] configures or sets the caption content which is inserted above the label
        # caption text [String] the caption text
        # caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
        # caption kwargs [Hash] additional arguments are applied as attributes on the caption +span+ element
        # kwargs [Hash] kwargs additional arguments are applied as attributes to the +input+ element
        # form_group [Hash] configures the form group
        # form_group kwargs [Hash] additional attributes added to the form group
        # show_password_text [String] button text when the password is hidden. Defaults to "Show"
        # hide_password_text [String] button text when the password is shown. Defaults to "Hide"
        # show_password_aria_label_text [String] button text exposed to assistive technologies, like screen readers,
        # when the password is hidden. Defaults to "Show password"
        # hide_password_aria_label_text [String] button text exposed to assistive technologies, like screen readers,
        # when the password is visible. Defaults to "Hide password"
        # password_shown_announcement_text [String] Announcement made to screen reader users when their password has
        # become visible in plain text. Defaults to "Your password is visible"
        # password_hidden_announcement_text [String] Announcement made to screen reader users when their password has
        # been obscured and is not visible. Defaults to "Your password is hidden"
        govuk_password_field(method, hint:, label:, caption: {}, form_group: {}, show_password_text: nil,
                                     hide_password_text: nil, show_password_aria_label_text: nil,
                                     hide_password_aria_label_text: nil, password_shown_announcement_text: nil,
                                     password_hidden_announcement_text: nil, **options)
      end

      # Same interface as ActionView::Helpers::FormHelper.text_area, but with label automatically added?
      def ds_text_area(method, options = {})
        label = options.delete(:label)
        label = { size: nil, text: label || translated_label(method) }
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        govuk_text_area(method, hint:, label:, caption: {}, max_words: nil, max_chars: nil, rows: 5, threshold: nil,
                                form_group: {}, **options)
      end

      # Select
      def ds_collection_select(method, collection, value_method, text_method, options = {})
        rails_options = options.extract!(:prompt, :include_blank)

        label = options.delete(:label)
        label = { size: nil, text: label } if label
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        govuk_collection_select(method, collection, value_method, text_method, options: rails_options, hint:, label:,
                                                                               caption: {}, form_group: {}, **options)
      end

      def ds_select(method, content_or_options = nil, options = nil)
        content, options = separate_content_or_options(content_or_options, options)
        choices = content

        rails_options = options.extract!(:prompt, :include_blank)

        label = options.delete(:label)
        label = { size: nil, text: label } if label
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        govuk_select(method, choices, options: rails_options, label:, hint:, form_group: {}, caption: {}, **options)
      end

      # Radio buttons
      def ds_collection_radio_buttons(method, collection, value_method, text_method = nil, hint_method = nil, **options)
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        legend = options.delete(:legend)
        legend = { text: legend } if legend

        govuk_collection_radio_buttons(method, collection, value_method, text_method, hint_method, hint:, legend:,
                                                                                                   caption: {}, inline: false, small: false, bold_labels: nil, include_hidden: config.default_collection_radio_buttons_include_hidden, form_group: {}, **options)
      end

      def ds_radio_buttons_fieldset(method, options = {}, &)
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        legend = options.delete(:legend)
        legend = { text: legend } if legend

        govuk_radio_buttons_fieldset(method,
                                     hint:, legend:, caption: {}, inline: false, small: false, form_group: {}, **options, &)
      end

      def ds_radio_button(method, value, options = {})
        label = { size: nil, text: translated_label(options.delete(:label) || value) }
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        govuk_radio_button(method, value, hint:, label:, link_errors: false, **options)
      end

      # Checkboxes
      def ds_collection_check_boxes(method, collection, value_method, text_method, hint_method = nil, **options)
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        legend = options.delete(:legend)
        legend = { text: legend } if legend

        govuk_collection_check_boxes(method, collection, value_method, text_method, hint_method, hint:, legend:,
                                                                                                 caption: {}, small: false, form_group: {}, include_hidden: config.default_collection_check_boxes_include_hidden, **options)
      end

      def ds_check_boxes_fieldset(method, options = {}, &)
        legend = { text: options.delete(:legend) || translated_label(method) }
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        govuk_check_boxes_fieldset(method,
                                   legend:, caption: {}, hint:, small: false, form_group: {}, multiple: true, **options, &)
      end

      def ds_check_box(method, value, unchecked_value = false, **options)
        label = { size: nil, text: translated_label(options.delete(:label) || value) }
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        govuk_check_box(method, value, unchecked_value, hint:, label:, link_errors: false, multiple: true,
                                                        exclusive: true, **options)
      end

      # Submit buttons
      def ds_submit(text = config.default_submit_button_text, **options)
        govuk_submit(text, warning: false, secondary: false, inverse: false, prevent_double_click: true,
                           validate: config.default_submit_validate, disabled: false, **options)
      end

      # Date field
      def ds_date_field(method, options = {})
        legend = options.delete(:legend)
        legend = { text: legend } if legend
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        govuk_date_field(method, hint:, legend:, caption: {}, date_of_birth: false, omit_day: false,
                                 maxlength_enabled: false, segments: config.default_date_segments, form_group: {}, **options)
      end

      # Error summary
      def ds_error_summary(title = config.default_error_summary_title, options = {})
        govuk_error_summary(title, presenter: config.default_error_summary_presenter, link_base_errors_to: nil,
                                   order: nil, **options)
      end

      # Fieldset
      def ds_fieldset(options = {}, &)
        legend = options.delete(:legend)
        legend = { text: legend || 'Fieldset heading' }

        govuk_fieldset(legend:, caption: {}, described_by: nil, **options, &)
      end

      # File field
      # Same interface as ActionView::Helpers::FormHelper.file_field, but with label automatically added
      def ds_file_field(method, options = {})
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        label = options.delete(:label)
        label = { size: nil, text: label || 'Upload file' }

        govuk_file_field(method, label:, caption: {}, hint:, form_group: {}, javascript: false, **options)
      end

      private

      def translated_label(method)
        # We need to retrieve the label translation in the same way as Tags::Label
        content ||= ActionView::Helpers::Tags::Translator.
                    new(object, object_name, method, scope: 'helpers.label').
                    translate
        content || method.humanize
      end
    end
  end
end
