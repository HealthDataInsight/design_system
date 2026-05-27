require 'erb'
require 'nokogiri'

# Helpers for the dummy app: component preview (ERB + rendered output).
module ApplicationHelper
  def component_preview(key = nil, html: nil, fragment: nil, &block)
    key = key || @component || @style
    heading, reference_url = component_preview_config(key)
    id = key.to_s.tr('_', '-')

    safe_buffer = ActiveSupport::SafeBuffer.new
    safe_buffer << ds_heading(heading, level: 3) if heading.present?
    safe_buffer << render_reference(reference_url) if reference_url.present?

    erb_source = capture(&block)
    display_source = hide_demo_attributes(erb_source)

    html ||= render(inline: erb_source)
    html = extract_html_fragment(html, fragment) if fragment
    pretty_html = pretty_print(html)

    safe_buffer << render_input(display_source, id)
    safe_buffer << render_output(html, pretty_html, id)
    safe_buffer
  end

  private

  def component_preview_config(key)
    entry = t("design_system.#{brand}.component_previews.#{key}", default: nil)
    return {} unless entry.is_a?(Hash)

    [entry[:heading], entry[:reference_url]]
  end

  def render_reference(reference_url)
    ds_inset_text do
      ds_paragraph do
        ds_link_to("View documentation", reference_url)
      end
    end
  end

  def hide_demo_attributes(erb_source)
    source = erb_source.to_s

    # Strip hacks like html: { onsubmit: 'return false;' } that are used to prevent form submission.
    source.gsub(/,\s*html:\s*\{\s*onsubmit:\s*'return false;'\s*\}/, '')
    # Add other hacks to remove as needed.
  end

  def extract_html_fragment(html, fragment)
    doc = Nokogiri::HTML.fragment(html)

    target_tag = case fragment
                 when :form_group
                   "div.#{brand}-form-group"
                 when :fieldset
                   "fieldset.#{brand}-fieldset"
                 end

    extracted = doc.at_css(target_tag)
    return html unless extracted

    extracted.to_xml(indent: 2).html_safe
  end

  def pretty_print(html)
    fragment = Nokogiri::HTML.fragment(html)

    fragment.traverse do |node|
      node.remove if node.text? && node.text.strip.empty?
    end

    fragment.children.map { |child| child.to_xml(indent: 2) }.join("\n")
  end

  def render_input(display_source, id)
    ds_heading('Input', level: 4) +
      ds_tab do |tab|
        tab.add_tab_panel('ERB (Ruby)', nil, "erb-#{id}", selected: true) { ds_code(display_source, 'ruby') }
      end
  end

  def render_output(html, pretty_html, id)
    ds_heading('Output', level: 4) +
      ds_tab do |tab|
        tab.add_tab_panel('Rendered', nil, "rendered-#{id}", selected: true) { html.html_safe }
        tab.add_tab_panel('HTML', nil, "html-#{id}") { ds_code(pretty_html, 'xml') }
      end
  end
end
