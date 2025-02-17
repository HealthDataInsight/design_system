# These are HDI specific view helper methods
module HdiHelper
  def nav_item_active?(item)
    # This helper checks if the navigation item should render in 'active' style
    options = item[:options] || {}

    return options[:active].call if options[:active].respond_to?(:call)
    return false if options[:controller].blank?

    params[:controller] == options[:controller]
  end

  def hdi_sidebar_navigation_svg(label, path, active, options = {}, &)
    icon_name = options[:icon] if options[:icon].present?
    svg_path = "/design_system/heroicons-2.1.5/icon-#{icon_name}.svg"

    css_classes = %w[
      group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold
    ]
    if active
      css_classes.push('bg-gray-50', 'text-indigo-600',
                       'dark:bg-gray-800', 'dark:text-indigo-300')
    else
      css_classes.push('text-gray-700', 'hover:text-indigo-600', 'hover:bg-gray-50',
                       'dark:text-gray-200', 'dark:hover:text-indigo-300', 'dark:hover:bg-gray-800')
    end

    options['class'] = css_classes.join(' ')
    link_to(path, **options) do
      hdi_sidebar_navigation_svg_tag(svg_path, active) + label
    end
  end

  private

  def hdi_sidebar_navigation_svg_tag(svg_path, active)
    svg_classes = %w[
      h-6 w-6 shrink-0
    ]
    if active
      svg_classes.push('text-indigo-600', 'dark:text-indigo-300')
    else
      svg_classes.push('text-gray-400', 'group-hover:text-indigo-600',
                       'dark:group-hover:text-indigo-300')
    end

    content_tag(:img, nil, src: svg_path, class: svg_classes.join(' '),
                           'aria-hidden': 'true')
  end
end
