# DesignSystem

[![Gem Version](https://badge.fury.io/rb/design_system.svg)](https://badge.fury.io/rb/design_system)

DesignSystem is an extensible Ruby on Rails engine that enables consistent, compliant web applications across design systems. It includes GOV.UK and NHS UK design systems and plugins are being developed for the National Disease Registration Service (NDRS), and Health Data Insight (HDI).

The gem provides unified form builders, UI components (tables, buttons, navigation, tabs), layouts, and styling that automatically adapt to each design system's specific requirements and branding guidelines.

Key features include:

- Multi-brand support: Seamlessly switch between GOV.UK, NHS and other design systems
- Unified API: Single set of helper methods (ds_form_with, ds_button_tag, ds_table, etc.) that work across all brands
- Signature parity: `ds_` prefixed helper methods have the same signature as their Rails equivalents (where possible)
- Form builders: Brand-specific form builders with automatic styling and accessibility features
- Component library: Pre-built components like tables, summary lists, tabs, navigation, and notifications
- Frontend integration: Includes bundled frontend assets and JavaScript for each design system
- Rails integration: Built as a Rails engine with Stimulus controllers for interactive components
- The gem abstracts away the complexity of working with different design systems, allowing developers to build compliant applications without managing brand-specific implementations manually.

## Usage

How to use the plugin.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "design_system"
```

And then execute:

```bash
bundle
```

Or install it yourself as:

```bash
gem install design_system
```

Add the following to `app/javascript/controllers/index.js`, after `import { application } from './application'`:

```javascript
import { registerControllers } from 'design_system/controllers'
registerControllers(application)
```

## Updating Frontends

### GOVUK Frontend (currently v5.9.0)

```bash
# Automatically fetch the latest
bundle exec rake app:make_govuk

# Update to a specific version
bundle exec rake app:make_govuk\[5.9.0\]
```

### NHSUK Frontend (currently v9.3.0)

```bash
# Automatically fetch the latest
bundle exec rake app:make_nhsuk

# Update to a specific version
bundle exec rake app:make_nhsuk\[9.3.0\]
```

### Shared Frontend Code

Before releasing a new version of the gem, rebuild the shared javascript code using:

```bash
bundle exec rake js:build
```

## Contributing

Contribution directions go here.

Created using:

```bash
rails plugin new design_system -MOC --skip-system-test --full --no-mountable
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
