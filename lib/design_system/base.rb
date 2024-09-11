require_relative 'builders/base/breadcrumbs'
require_relative 'builders/base/form'
require_relative 'builders/base/headings'
require_relative 'builders/base/table'

module DesignSystem
  # This is the base class for design system adapters
  class Base
    include Builders::Base::Breadcrumbs
    include Builders::Base::Form
    include Builders::Base::Headings

    delegate :capture, :content_for, :content_tag, :link_to, :link_to_unless_current, to: :@context

    def initialize(context)
      @context = context
    end

    def brand
      self.class.name.split('::').last.underscore
    end

    def render
      content_for_breadcrumbs if @breadcrumbs.present?

      render_main_container do
        safe_buffer = ActiveSupport::SafeBuffer.new

        safe_buffer.concat(render_main_heading) if @main_heading
        safe_buffer.concat(render_form) if @form_object
        safe_buffer
      end
    end

    private

    def render_main_container(&)
      content_tag(:div, &)
    end
  end
end
