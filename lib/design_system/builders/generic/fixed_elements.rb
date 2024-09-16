# frozen_string_literal: true

require_relative 'base'
require_relative 'elements/breadcrumbs'
require_relative 'elements/form'
require_relative 'elements/headings'

module DesignSystem
  module Builders
    module Generic
      # This class is used to provide the generic fixed elements builder.
      class FixedElements < Base
        include Elements::Breadcrumbs
        include Elements::Form
        include Elements::Headings

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
  end
end
