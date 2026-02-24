require 'erb'
require 'nokogiri'

# Helpers for the dummy app: sidebar navigation, component preview (ERB + rendered output).
module ApplicationHelper
  def sidebar(content, type: :item, level: 4)
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

  # Renders a component preview: Input tab (ERB snippet) and Output tab (Rendered + HTML).
  # @param extract [Symbol, nil] when :form_group, only the content within the first div.#{brand}-form-group is shown in output
  # When rendering erb code, send in your code without indentation to avoid extra whitespace.
  def component_preview(extract: nil, &block)
    erb_source = capture(&block)
    html = ERB.new(erb_source).result(binding)
    html = extract_form_component(html) if extract == :form_group
    pretty_html = pretty_print_html(html)

    safe_buffer = ActiveSupport::SafeBuffer.new
    safe_buffer << ds_heading('Input', level: 4)
    safe_buffer << component_preview_input_tab(erb_source)
    safe_buffer << ds_heading('Output', level: 4)
    safe_buffer << component_preview_output_tab(html, pretty_html)
    safe_buffer
  end

  private

  def component_preview_input_tab(erb_source)
    ds_tab do |tab|
      tab.add_tab_panel('ERB', nil, 'erb', selected: true) { ds_code(erb_source.to_s, 'ruby') }
    end
  end

  def component_preview_output_tab(html, pretty_html)
    ds_tab do |tab|
      tab.add_tab_panel('Rendered', nil, 'rendered', selected: true) { html.html_safe }
      tab.add_tab_panel('HTML', nil, 'html') { ds_code(pretty_html, 'xml') }
    end
  end

  def pretty_print_html(html)
    fragment = Nokogiri::HTML.fragment(html)
    fragment.children.map { |child| child.to_xml(indent: 2) }.join("\n")
  end

  def extract_form_component(html)
    doc = Nokogiri::HTML.fragment(html)
    form_group = doc.at_css("div.#{brand}-form-group")
    return html unless form_group

    form_group.to_xml(indent: 2).html_safe
  end
end
