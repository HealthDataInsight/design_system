# These are HDI specific view helper methods
module HdiHelper
  def hdi_sidebar_navigation_svg(item)
    path = item[:path]
    active = current_page?(path)
    options = item[:options] || {}

    icon_name = options[:icon] if options[:icon].present?
    svg_path = "/design_system/static/hdi-frontend-0.10.0/icons/icon-#{icon_name}.svg"

    options['class'] = if active
                         "#{brand}-icon-link__active"
                       else
                         "#{brand}-icon-link"
                       end

    link_to(path, **options) do
      hdi_sidebar_navigation_svg_tag(svg_path, active) + item[:label]
    end
  end

  private

  def hdi_sidebar_navigation_svg_tag(svg_path, active)
    style = if active
              "#{brand}-icon #{brand}-icon-label__active"
            else
              "#{brand}-icon #{brand}-icon-label"
            end

    content_tag(:img, nil, src: svg_path, class: style,
                           'aria-hidden': 'true')
  end
end
