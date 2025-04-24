# These are HDI specific view helper methods
module HdiHelper
  def hdi_sidebar_navigation_svg(item)
    path = item[:path]
    active = current_page?(path)
    options = item[:options] || {}

    icon_name = options[:icon] if options[:icon].present?
    svg_path = "/design_system/static/heroicons-2.1.5/icon-#{icon_name}.svg"

    options['class'] = ['sidebar-item']
    options['class'] << 'sidebar-item--active' if active

    link_to(path, **options) do
      hdi_sidebar_navigation_svg_tag(svg_path, active) + item[:label]
    end
  end

  private

  def hdi_sidebar_navigation_svg_tag(svg_path, active)
    content_tag(:img, nil, src: svg_path, class: 'hdi-icon', 'aria-hidden': 'true')
  end
end
