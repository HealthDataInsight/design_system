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

          def render_backlink(label = @label, path = @path)
            content_tag(:a, label, href: path, class: "#{brand}-back-link")
          end
        end
      end
    end
  end
end
