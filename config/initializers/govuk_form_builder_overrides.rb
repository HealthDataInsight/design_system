require 'govuk_design_system_formbuilder'

module GOVUKDesignSystemFormBuilder
  class Base
    # Builds the values used for HTML id attributes throughout the builder
    # A monkey patch to build component identifiers in rails style (use underscores instead of dashes)
    #
    # @param id_type [String] a description of the id's type, eg +hint+, +error+
    # @param delimiter [String] the characters used to 'split' the output
    # @param replace [String] a placeholder for coping with govuk_design_system_formbuilder callers where it expects a replace argument
    # @param attribute_name [String] overrides the object's +@attribute_name+
    # @param include_value [Boolean] controls whether or not the value will form part
    #   of the final id
    #
    # @return [String] the id composed of object, attribute, value and type
    #
    # @example
    #   build_id('hint') #=> "person_name_hint"
    def build_id(id_type, delimiter = '_', _replace = '_', attribute_name: nil, include_value: true)
      attribute = attribute_name || @attribute_name
      value     = (include_value && @value) || nil

      parts = [@object_name, attribute, value]
      parts << id_type unless id_type.empty?

      parts.compact.join(delimiter)
    end

    # @example
    #   field_id #=> "person_name"
    #   field_id(link_errors: true) #=> "person_name_error"
    def field_id(link_errors: false)
      if link_errors && has_errors?
        build_id('error', include_value: false)
      else
        build_id('')
      end
    end
  end

  module Elements
    class ErrorSummary
      def field_id(attribute)
        if attribute.eql?(:base) && @link_base_errors_to.present?
          build_id('', attribute_name: @link_base_errors_to)
        else
          build_id('error', attribute_name: attribute)
        end
      end
    end

    class Label
      private

      def retrieve_text(option_text, hidden)
        text = [option_text, localised_text(:label), @attribute_name.capitalize].find(&:presence)
        hidden_class = brand.in?(%w[nhsuk ndrsuk]) ? 'u-visually-hidden' : 'visually-hidden'

        if hidden
          tag.span(text, class: %(#{brand}-#{hidden_class}))
        else
          text
        end
      end
    end

    class Legend
      using PrefixableArray

      private

      def classes
        hidden_class = brand.in?(%w[nhsuk ndrsuk]) ? 'u-visually-hidden' : 'visually-hidden'
        build_classes(
          %(fieldset__legend),
          @size_class,
          hidden_class => @hidden
        ).prefix(brand)
      end
    end
  end

  module Traits
    module Error
      private

      def error_element
        # Check if @html_attributes is defined and contains the suppress_error key.
        # This instance variable is typically set by other traits like Traits::Input or Traits::Field.
        if instance_variable_defined?(:@html_attributes) &&
           @html_attributes&.key?(:suppress_error) &&
           @html_attributes[:suppress_error]
          @error_element = NullErrorElement.new(*bound) # Suppress the error message
        else
          # The `bound` method (from Elements::Base) provides [@builder, @object_name, @attribute_name].
          @error_element ||= GOVUKDesignSystemFormBuilder::Elements::ErrorMessage.new(*bound)
        end
      end
    end
  end

  # Null Object for suppressed error messages
  class NullErrorElement
    # Takes the same arguments as the real ErrorMessage constructor for compatibility
    def initialize(builder, object_name, attribute_name, **_kwargs)
      # We don't need to store them for this null object
    end

    def html
      ActiveSupport::SafeBuffer.new # Renders no HTML
    end

    def to_s
      '' # Returns an empty string if the object itself is converted to a string
    end

    def error_id
      nil # Important for aria-describedby, indicates no specific error ID
    end

    private

    def has_errors?
      false # So it doesn't try to render itself as if it has errors
    end
  end
end
