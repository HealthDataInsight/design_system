module ApplicationHelper
  # Renders a sidebar element - either a heading or a list item
  # @param content [String, Array] Heading text or [label, path] array for item
  # @param type [Symbol] :heading or :item (default: :item)
  # @param level [Integer] Heading level when type is :heading (default: 5)
  # @example
  #   ds_sidebar('Design', type: :heading)
  #   ds_sidebar(['Components', components_path])
  #   ds_sidebar(['Buttons', component_path('buttons')])
  def ds_sidebar(content, type: :item, level: 4)
    case type
    when :heading
      ds_heading(content, level: level)
    when :item
      label, path = content.is_a?(Array) ? content : [content, nil]
      path ||= component_path(label.parameterize)
      
      content_tag(:li, class: "#{brand}-list__item") do
        ds_link_to(label, path, class: "#{brand}-list__link")
      end
    else
      raise ArgumentError, "Unknown type: #{type}. Use :heading or :item"
    end
  end
end
