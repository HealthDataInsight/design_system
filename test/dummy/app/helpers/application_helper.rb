require 'erb'

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
    html = render(inline: erb_source)

    template = ERB.new(erb_source)
    html_string = template.result(binding)

    # html_string = html.instance_of?(ActiveSupport::SafeBuffer) ? html.to_str : html.to_s
  
    safe_buffer = ActiveSupport::SafeBuffer.new
    safe_buffer << ds_heading('Input', level: 4)
    safe_buffer << ds_code(erb_source)
    safe_buffer << ds_heading('Output', level: 4)
    safe_buffer << ds_tab do |tab|
      tab.add_tab_panel('Rendered', nil, 'rendered', selected: true) do
        html.html_safe
      end

      tab.add_tab_panel('HTML', nil, 'html') do
        ds_code(html_string)
      end
    end
    
    safe_buffer
  end
end
