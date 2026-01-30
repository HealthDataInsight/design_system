# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      # This class provides generic methods to display action links, which should be used to signpost the start of a digital service.
      class ActionLink < Base
        def render_action_link(name = nil, options = nil, html_options = nil)
          options ||= {}
          html_options ||= {}

          prep_style(name, options, html_options)
        end
      end
    end
  end
end