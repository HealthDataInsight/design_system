module DesignSystem
  module Nhsuk
    # NHS inset text adds a visually hidden "Information:" prefix and wraps
    # plain text content in a paragraph (block content is left as-is).
    class InsetTextComponent < DesignSystem::Generic::InsetTextComponent
      def wrapped_body
        content.presence || content_tag(:p, text)
      end
    end
  end
end
