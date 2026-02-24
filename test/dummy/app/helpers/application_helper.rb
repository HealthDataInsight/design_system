require 'erb'
require 'nokogiri'

module ApplicationHelper
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

  def component_preview(&block)
    erb_source = capture(&block)
    html = ERB.new(erb_source).result(binding)
    pretty_html = pretty_print_html(html)
  
    safe_buffer = ActiveSupport::SafeBuffer.new

    safe_buffer << ds_heading('Input', level: 4)
    safe_buffer << ds_code(erb_source, 'erb')

    safe_buffer << ds_heading('Output', level: 4)
    safe_buffer << ds_tab do |tab|
      tab.add_tab_panel('Rendered', nil, 'rendered', selected: true) do
        html.html_safe
      end
      tab.add_tab_panel('HTML', nil, 'html') do
        ds_code(pretty_html, 'xml')
      end
    end
    
    safe_buffer
  end

  private

  def pretty_print_html(html)
    fragment = Nokogiri::HTML.fragment(html)
    fragment.children.map { |child| child.to_xml(indent: 2) }.join("\n")
  end
end
