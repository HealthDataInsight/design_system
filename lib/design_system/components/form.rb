module DesignSystem
  module Components
    # This mixin module is used to provide a form.
    module Form
      def form(object)
        @form_object = object
      end

      private

      def render_form
        name = @form_object.class.name.underscore

        options = { name.to_sym => @context.instance_variable_get(:"@#{name}") }
        @context.render('form', options)
      end
    end
  end
end
