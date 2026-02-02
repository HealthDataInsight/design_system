# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      module Elements
        # This mixin module is used to provide back link.
        module Backlink
          def backlink(label, path)
            @backlink = true
            @label = label || 'Back'
            @path = path
          end

          private

          def content_for_backlink
            content_for(:backlink) do
              render_backlink
            end
          end

          def render_backlink
            link_to(@label, @path, class: "#{brand}-back-link")
          end
        end
      end
    end
  end
end
