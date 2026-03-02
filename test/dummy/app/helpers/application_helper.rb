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

  # Renders a component preview: Input tab (source code) and Output tab (rendered HTML + prettified markup).
  #
  # - erb_source:  String of ERB or Ruby to show in the "Input" tab. Defaults to the captured block.
  # - html:        Raw HTML to use for the "Rendered" output. If omitted, we render the ERB in +erb_source+.
  # - component:     When :form, only the first div.#{brand}-form-group is shown in the rendered output.
  def component_preview(html: nil, component: nil, &block)
    erb_source = capture(&block)
    html ||= render(inline: erb_source)
    html = render_form_component(html) if component == :form
    pretty_html = pretty_print(html)

    safe_buffer = ActiveSupport::SafeBuffer.new
    safe_buffer << render_input(erb_source)
    safe_buffer << render_output(html, pretty_html)
    safe_buffer
  end

  private

  def render_input(erb_source)
    ds_heading('Input', level: 4) +
    ds_tab do |tab|
      tab.add_tab_panel('ERB (Ruby)', nil, 'erb (ruby)', selected: true) { ds_code(erb_source.to_s, 'ruby') }
    end
  end

  def render_output(html, pretty_html)
    ds_heading('Output', level: 4) +
    ds_tab do |tab|
      tab.add_tab_panel('Rendered', nil, 'rendered', selected: true) { html.html_safe }
      tab.add_tab_panel('HTML', nil, 'html') { ds_code(pretty_html, 'xml') }
    end
  end

  def pretty_print(html)
    fragment = Nokogiri::HTML.fragment(html)
    fragment.children.map { |child| child.to_xml(indent: 2) }.join("\n")
  end

  # TODO: fix this to extract the form component correctly (handle modifiers like nhsuk-form-group--error)
  def render_form_component(html)
    doc = Nokogiri::HTML.fragment(html)
    form_group = doc.at_css("div.#{brand}-form-group")
    return html unless form_group

    form_group.to_xml(indent: 2).html_safe
  end
end
