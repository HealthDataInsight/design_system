# frozen_string_literal: true

module DesignSystem
  module Govuk
    module Builders
      # This class provides GOVUK Action Link. GOVUK doesn't have a specific action link component, so we use the button styled link component.
      class ActionLink < ::DesignSystem::Generic::Builders::ActionLink
        private

        def prep_style(name, options, html_options)
          html_options[:class] = "#{brand}-button"
          link_to(name, options, html_options)
        end
      end
    end
  end
end
