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
  end
end
