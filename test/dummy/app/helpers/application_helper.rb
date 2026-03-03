require 'erb'
require 'nokogiri'

# Helpers for the dummy app: component preview (ERB + rendered output).
module ApplicationHelper
  def component_preview(html: nil, component: nil, id: nil, &block)
    erb_source = capture(&block)
    display_source = hide_demo_attributes(erb_source)

    html ||= render(inline: erb_source)
    html = extract_component(html, component) if component
    pretty_html = pretty_print(html)

    safe_buffer = ActiveSupport::SafeBuffer.new
    safe_buffer << render_input(display_source, id)
    safe_buffer << render_output(html, pretty_html, id)
    safe_buffer
  end

  private

  def hide_demo_attributes(erb_source)
    source = erb_source.to_s

    # Strip hacks like html: { onsubmit: 'return false;' } that are used to prevent form submission.
    source.gsub(/,\s*html:\s*\{\s*onsubmit:\s*'return false;'\s*\}/, '')
  end

  def render_input(erb_source, id)
    ds_heading('Input', level: 4) +
      ds_tab do |tab|
        tab.add_tab_panel('ERB (Ruby)', nil, "erb-#{id}", selected: true) { ds_code(erb_source.to_s, 'ruby') }
      end
  end

  def render_output(html, pretty_html, id)
    ds_heading('Output', level: 4) +
      ds_tab do |tab|
        tab.add_tab_panel('Rendered', nil, "rendered-#{id}", selected: true) { html.html_safe }
        tab.add_tab_panel('HTML', nil, "html-#{id}") { ds_code(pretty_html, 'xml') }
      end
  end

  def pretty_print(html)
    fragment = Nokogiri::HTML.fragment(html)

    fragment.traverse do |node|
      node.remove if node.text? && node.text.strip.empty?
    end

    fragment.children.map { |child| child.to_xml(indent: 2) }.join("\n")
  end

  def extract_component(html, component)
    doc = Nokogiri::HTML.fragment(html)

    target_tag = case component
                 when :form_group
                   "div.#{brand}-form-group"
                 when :fieldset
                   "fieldset.#{brand}-fieldset"
                 end

    extracted = doc.at_css(target_tag)
    return html unless extracted

    extracted.to_xml(indent: 2).html_safe
  end
end
