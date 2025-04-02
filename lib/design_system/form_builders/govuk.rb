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
      # ds_collection_select
      # ds_date_field
      # ds_email_field
      # ds_file_field
      # ds_label
      # ds_number_field
      # ds_password_field
      # ds_phone_field
      # ds_select
      # ds_submit
      # ds_text_area
      # ds_text_field
      # ds_url_field

      # TODO: will be supported in next PR
      # dividers
      # ds_check_box
      # ds_check_boxes_fieldset
      # ds_collection_check_boxes
      # ds_collection_radio_buttons
      # ds_error_summary
      # ds_fieldset
      # ds_radio_button
      # ds_radio_buttons_fieldset

      def ds_collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
        options, html_options = separate_rails_or_html_options(options, html_options)

        label = { size: nil, text: translated_label(method) }
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        # attribute_name [Symbol] The name of the attribute
        # collection [Enumerable<Object>] Options to be added to the +select+ element
        # value_method [Symbol] The method called against each member of the collection to provide the value
        # text_method [Symbol] The method called against each member of the collection to provide the text
        # options (rails_options) [Hash] Options hash passed through to Rails' +collection_select+ helper
        govuk_collection_select(method, collection, value_method, text_method, options:, hint:, label:,
                                                                               caption: {}, form_group: {}, **html_options)
      end

      def ds_date_field(method, options = {})
        legend = options.delete(:legend)
        legend = { text: legend } if legend
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        # omit_day [Boolean] do not render a day input, only capture month and year
        # maxlength_enabled [Boolean] adds maxlength attribute to day, month and year inputs (2, 2, and 4, respectively)
        # segments [Hash] allows Rails' multiparameter attributes to be overridden on a field-by-field basis. Hash must
        #   contain +day:+, +month:+ and +year:+ keys. Defaults to the default value set in the +default_date_segments+ setting in {GOVUKDesignSystemFormBuilder.DEFAULTS}
        # date_of_birth [Boolean] if +true+ {https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/autocomplete#Values birth date auto completion attributes}
        #   will be added to the inputs
        govuk_date_field(method, hint:, legend:, caption: {}, date_of_birth: false, omit_day: false,
                                 maxlength_enabled: false, segments: config.default_date_segments, form_group: {}, **options)
      end

      def ds_email_field(method, options = {})
        label = { size: nil, text: translated_label(method) }
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        govuk_email_field(method, hint:, label:, caption: {}, width: nil, extra_letter_spacing: false, form_group: {},
                                  prefix_text: nil, suffix_text: nil, **options)
      end

      # Same interface as ActionView::Helpers::FormHelper.file_field, but with label automatically added
      def ds_file_field(method, options = {})
        hint = options.delete(:hint)
        hint = { text: hint } if hint
        label = { size: nil, text: translated_label(method) }

        # javascript [Boolean] Configures whether to add HTML for the javascript-enhanced version of the component
        govuk_file_field(method, label:, caption: {}, hint:, form_group: {}, javascript: false, **options)
      end

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

      def ds_number_field(method, options = {})
        label = { size: nil, text: translated_label(method) }
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        govuk_number_field(method, hint:, label:, caption: {}, width: nil, extra_letter_spacing: false, form_group: {},
                                   prefix_text: nil, suffix_text: nil, **options)
      end

      # Same interface as ActionView::Helpers::FormHelper.password_field, but with label automatically added.
      def ds_password_field(method, options = {})
        label = { size: nil, text: translated_label(method) }
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

      def ds_phone_field(method, options = {})
        label = { size: nil, text: translated_label(method) }
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        govuk_phone_field(method, hint:, label:, caption: {}, width: nil, extra_letter_spacing: false, form_group: {},
                                  prefix_text: nil, suffix_text: nil, **options)
      end

      def ds_select(method, choices = nil, options = nil, html_options = nil, &)
        choices, options, html_options = separate_choices_or_options(choices, options, html_options)

        label = { size: nil, text: translated_label(method) }
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        # choices [Array,Hash] The +option+ values, usually provided via
        #   the +options_for_select+ or +grouped_options_for_select+ helpers.
        govuk_select(method, choices, options:, label:, hint:, form_group: {}, caption: {}, **html_options, &)
      end

      def ds_submit(value = nil, **options, &)
        # text [String,Proc] the button text. When a +Proc+ is provided its contents will be rendered within the button element
        # warning [Boolean] makes the button red ({https://design-system.service.gov.uk/components/button/#warning-buttons warning}) when true
        # secondary [Boolean] makes the button grey ({https://design-system.service.gov.uk/components/button/#secondary-buttons secondary}) when true
        # inverse [Boolean] inverts the colours of the button. Note this isn't yet part of the design system.
        # prevent_double_click [Boolean] adds JavaScript to safeguard the
        #   form from being submitted more than once
        # validate [Boolean] adds the formnovalidate to the submit button when true, this disables all
        #   client-side validation provided by the browser. This is to provide a more consistent and accessible user
        #   experience
        # disabled [Boolean] makes the button disabled when true
        # kwargs [Hash] kwargs additional arguments are applied as attributes to the +button+ element
        # block [Block] When content is passed in via a block the submit element and the block content will
        #   be wrapped in a +<div class="govuk-button-group">+ which will space the buttons and links within
        #   evenly.
        govuk_submit(text = value || config.default_submit_button_text, warning: false, secondary: false, inverse: false, prevent_double_click: true,
                                                                        validate: config.default_submit_validate, disabled: false, **options, &)
      end

      def ds_text_area(method, options = {})
        label = { size: nil, text: translated_label(method) }
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        # max_words [Integer] adds the GOV.UK max word count
        # max_chars [Integer] adds the GOV.UK max characters count
        # threshold [Integer] only show the +max_words+ and +max_chars+ warnings once a threshold (percentage) is reached
        # rows [Integer] sets the initial number of rows
        govuk_text_area(method, hint:, label:, caption: {}, max_words: nil, max_chars: nil, rows: 5, threshold: nil,
                                form_group: {}, **options)
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

      def ds_url_field(method, options = {})
        label = { size: nil, text: translated_label(method) }
        hint = options.delete(:hint)
        hint = { text: hint } if hint

        govuk_url_field(method, hint:, label:, caption: {}, width: nil, extra_letter_spacing: false, form_group: {},
                                prefix_text: nil, suffix_text: nil, **options)
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
