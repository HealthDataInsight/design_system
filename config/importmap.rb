pin 'ds-stimulus-loading', to: '/design_system/static/stimulus-3.2.2/stimulus-loading.js'
# We pin the design system controllers to the importmap, so they can be imported,
# rather than just be included in the HTML.
pin 'design_system/controllers', to: "/design_system/static/design_system-#{DesignSystem::VERSION}/design_system.js"
