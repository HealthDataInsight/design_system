require 'erb'
require 'nokogiri'

# Helpers for the dummy app: component preview (ERB + rendered output).
module ApplicationHelper
  # Bundled frontend version for a brand (e.g. "5.11.1" for govuk), read from the
  # gem's stylesheet directory name so it stays accurate when frontends are updated.
  def frontend_version(brand_name)
    pattern = DesignSystem::Engine.root.join("app/assets/stylesheets/design_system/#{brand_name}-frontend-*")
    dir = Dir.glob(pattern).first
    return unless dir

    File.basename(dir).delete_prefix("#{brand_name}-frontend-")
  end

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

    # The rendered preview is what pa11y/axe scans. Because a page can preview the same
    # component more than once, prefix element ids (and their references) per preview so the
    # live DOM stays free of duplicate ids. pretty_html above keeps the original ids so the
    # displayed code sample is unchanged.
    html = uniquify_ids(html, id)

    safe_buffer << render_input(display_source, id)
    safe_buffer << render_output(html, pretty_html, id)
    safe_buffer
  end

  private

  def component_preview_config(key)
    entry = t("design_system.#{brand}.component_previews.#{key}", default: nil)
    return [nil, nil] unless entry.is_a?(Hash)

    [entry[:heading], entry[:reference_url]]
  end

  def render_reference(reference_url)
    ds_inset_text do
      ds_paragraph do
        ds_link_to('View documentation', reference_url)
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

  # Prefix every element id in +html+ with +prefix+ and update the attributes that reference
  # those ids, so labels and aria-* associations keep resolving. Keeps a page free of duplicate
  # ids when the same component is previewed more than once.
  def uniquify_ids(html, prefix)
    doc = Nokogiri::HTML.fragment(html)
    id_map = prefix_element_ids(doc, prefix)
    return html if id_map.empty?

    remap_single_idrefs(doc, id_map)
    remap_idref_lists(doc, id_map)
    remap_anchor_hrefs(doc, id_map)

    # Returned as a plain String; render_output marks it html_safe when it embeds the preview.
    doc.to_html
  end

  # Rewrite every id to be prefixed and return { old_id => new_id }.
  def prefix_element_ids(doc, prefix)
    doc.css('[id]').each_with_object({}) do |node, map|
      new_id = "#{prefix}-#{node['id']}"
      map[node['id']] = new_id
      node['id'] = new_id
    end
  end

  # Single-idref attributes: the whole value is one id (a demo value like "Jacket potato"
  # can even contain spaces), so map it as a whole rather than splitting.
  def remap_single_idrefs(doc, id_map)
    %w[for list aria-activedescendant].each do |attr|
      doc.css("[#{attr}]").each { |node| node[attr] = id_map[node[attr]] || node[attr] }
    end
  end

  # Space-separated idref lists (aria-labelledby, aria-describedby, ...).
  def remap_idref_lists(doc, id_map)
    %w[aria-labelledby aria-describedby aria-controls aria-owns aria-details headers].each do |attr|
      doc.css("[#{attr}]").each do |node|
        node[attr] = node[attr].split(/\s+/).map { |ref| id_map[ref] || ref }.join(' ')
      end
    end
  end

  # In-page anchors (e.g. tab links, whose aria-controls is derived from the href by JS).
  def remap_anchor_hrefs(doc, id_map)
    doc.css('a[href^="#"]').each do |node|
      target = node['href'].delete_prefix('#')
      node['href'] = "##{id_map[target]}" if id_map.key?(target)
    end
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
