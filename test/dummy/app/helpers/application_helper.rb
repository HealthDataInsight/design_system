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

  def component_preview(form_component: false, &block)
    erb_source = capture(&block)
    html = ERB.new(erb_source).result(binding)
    html = extract_form_component(html) if form_component
    pretty_html = pretty_print_html(html)

    safe_buffer = ActiveSupport::SafeBuffer.new

    safe_buffer << ds_heading('Input', level: 4)
    safe_buffer << ds_tab do |tab|
      tab.add_tab_panel('ERB', nil, 'erb', selected: true) do
        ds_code(erb_source.to_s, 'ruby')
      end
    end

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

  def extract_form_component(html)
    doc = Nokogiri::HTML.fragment(html)
    form_group = doc.at_css('div.govuk-form-group')
    return html unless form_group

    form_group.to_html.html_safe
  end
end
