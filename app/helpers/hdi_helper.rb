# These are HDI specific view helper methods
module HdiHelper
  def hdi_sidebar_navigation_svg(item)
    path = item[:path]
    active = current_page?(path)
    options = item[:options] || {}

    icon_name = options[:icon] if options[:icon].present?
    svg_path = "/design_system/static/hdi-frontend-0.10.0/icons/icon-#{icon_name}.svg"

    options['class'] = if active
                         "#{brand}-sidebar-item #{brand}-sidebar-item--active"
                       else
                         "#{brand}-sidebar-item"
                       end

    link_to(path, **options) do
      hdi_sidebar_navigation_svg_tag(svg_path, active) + item[:label]
    end
  end

  private

  def hdi_sidebar_navigation_svg_tag(svg_path, active)
    content_tag(:img, nil, src: svg_path, class: "#{brand}-icon",
                           'aria-hidden': 'true')
  end
end
