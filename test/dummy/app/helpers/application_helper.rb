require 'erb'
require 'nokogiri'

# Helpers for the dummy app: component preview (ERB + rendered output).
module ApplicationHelper
  # Renders a component preview: Input tab (source code) and Output tab (rendered HTML + prettified markup).
  #
  # - erb_source:  String of ERB or Ruby to show in the "Input" tab. Defaults to the captured block.
  # - html:        Raw HTML to use for the "Rendered" output. If omitted, we render the ERB in +erb_source+.
  # - component:   When :form, only the first div.#{brand}-form-group is shown in the rendered output.
  # - id:          Optional semantic base id used for tab panel IDs.
  def component_preview(html: nil, component: nil, id: nil, &block)
    erb_source = capture(&block)
    html ||= render(inline: erb_source)
    html = render_form_component(html) if component == :form
    pretty_html = pretty_print(html)

    safe_buffer = ActiveSupport::SafeBuffer.new
    safe_buffer << render_input(erb_source, id)
    safe_buffer << render_output(html, pretty_html, id)
    safe_buffer
  end

  private

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
    fragment.children.map { |child| child.to_xml(indent: 2) }.join("\n")
  end

  def render_form_component(html)
    doc = Nokogiri::HTML.fragment(html)
    form_group = doc.at_css("div.#{brand}-form-group")
    return html unless form_group

    form_group.to_xml(indent: 2).html_safe
  end
end
