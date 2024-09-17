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

      # TODO: Same interface as ActionView::Helpers::FormHelper.file_field, but with label automatically added?
      # def ds_file_field(method, options = {})
      # end

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

      # Same interface as ActionView::Helpers::FormHelper.password_field, but with label automatically added.
      def ds_password_field(method, options = {})
        label = { size: nil, text: translated_label(method) }

        # hint [Hash,Proc] The content of the hint. No hint will be added if 'text' is left +nil+. When a +Proc+ is
        #   supplied the hint will be wrapped in a +div+ instead of a +span+
        # hint text [String] the hint text
        # hint kwargs [Hash] additional arguments are applied as attributes to the hint
        # label [Hash,Proc] configures or sets the associated label content
        # label text [String] the label text
        # label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
        # label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
        # label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
        # label kwargs [Hash] additional arguments are applied as attributes on the +label+ element
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
        govuk_password_field(method, hint: {}, label:, caption: {}, form_group: {}, show_password_text: nil,
                                     hide_password_text: nil, show_password_aria_label_text: nil,
                                     hide_password_aria_label_text: nil, password_shown_announcement_text: nil,
                                     password_hidden_announcement_text: nil, **options)
      end

      # TODO: Same interface as ActionView::Helpers::FormHelper.text_area, but with label automatically added?
      # def ds_text_area(method, options = {})
      # end

      # Same interface as ActionView::Helpers::FormHelper.text_field, but with label automatically added.
      def ds_text_field(method, options = {})
        label = { size: nil, text: translated_label(method) }

        # hint [Hash,Proc] The content of the hint. No hint will be added if 'text' is left +nil+. When a +Proc+ is
        #   supplied the hint will be wrapped in a +div+ instead of a +span+
        # hint text [String] the hint text
        # hint kwargs [Hash] additional arguments are applied as attributes to the hint
        #
        # width [Integer,String] sets the width of the input, can be +2+, +3+ +4+, +5+, +10+ or +20+ characters
        #   or +one-quarter+, +one-third+, +one-half+, +two-thirds+ or +full+ width of the container
        # extra_letter_spacing [Boolean] when true adds space between characters to increase the readability of
        #   sequences of letters and numbers. Defaults to +false+.
        # label [Hash,Proc] configures or sets the associated label content
        # caption [Hash] configures or sets the caption content which is inserted above the label
        # caption text [String] the caption text
        # caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
        # caption kwargs [Hash] additional arguments are applied as attributes on the caption +span+ element
        # form_group [Hash] configures the form group
        # form_group kwargs [Hash] additional attributes added to the form group
        # prefix_text [String] the text placed before the input. No prefix will be added if left +nil+
        # suffix_text [String] the text placed after the input. No suffix will be added if left +nil+
        # block [Block] arbitrary HTML that will be rendered between the hint and the input
        govuk_text_field(method, hint: {}, label:, caption: {}, width: nil, extra_letter_spacing: false,
                                 form_group: {}, prefix_text: nil, suffix_text: nil, **options)
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
