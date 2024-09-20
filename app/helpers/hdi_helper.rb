# These are HDI specific view helper methods
module HdiHelper
  def hdi_sidebar_navigation_svg(label, path, active, options = {}, &block)
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
      hdi_sidebar_navigation_svg_tag(active, &block) + label
    end
  end

  private

  def hdi_sidebar_navigation_svg_tag(active, &)
    svg_classes = %w[
      h-6 w-6 shrink-0
    ]
    if active
      svg_classes.push('text-indigo-600', 'dark:text-indigo-300')
    else
      svg_classes.push('text-gray-400', 'group-hover:text-indigo-600',
                       'dark:group-hover:text-indigo-300')
    end
    content_tag(:svg,
                xmlns: 'http://www.w3.org/2000/svg',
                fill: 'none',
                viewBox: '0 0 24 24',
                'stroke-width': '1.5',
                stroke: 'currentColor',
                'aria-hidden': 'true',
                class: svg_classes.join(' '), &)
  end
end
