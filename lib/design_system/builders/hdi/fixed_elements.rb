# frozen_string_literal: true

require 'design_system/builders/generic/fixed_elements'
require_relative 'elements/breadcrumbs'
require_relative 'elements/headings'

module DesignSystem
  module Builders
    module Hdi
      # This class is used to provide HDI fixed elements builder.
      class FixedElements < ::DesignSystem::Builders::Generic::FixedElements
        include Elements::Breadcrumbs
        include Elements::Headings

        def render
          content_for_breadcrumbs if @breadcrumbs.present?

          render_main_container do
            safe_buffer = ActiveSupport::SafeBuffer.new

            safe_buffer.concat(render_main_heading) if @main_heading
            safe_buffer.concat(render_caption) if @caption
            safe_buffer.concat(render_form) if @form_object

            safe_buffer
          end
        end
      end
    end
  end
end
