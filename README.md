# DesignSystem
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "design_system"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install design_system
```

Add the following to `app/assets/config/manifest.js`:

```ruby
//= link design_system/controllers/index.js
```

Add the following to `app/javascript/controllers/index.js`:

```javascript
import { registerControllers } from "design_system/controllers"
registerControllers(application)
```

## Updating Frontends

### GOVUK Frontend (currently v5.3.1)
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

### NDRSUK Frontend (currently v8.1.1)
```bash
# NDRSUK Version number must be explicitly specified (no 'latest' support)
bundle exec rake app:make_nhsuk\[9.3.0\]
```
There is additional information in the [ndrsuk-frontend repo](https://github.com/HealthDataInsight/ndrsuk-frontend)'s README.md.


## Build Tailwind CSS with a custom config

If you are self-hosting Tailwind in your host app, you need to import the styles and utilities via design system.

Create an input CSS file (`input.css`) to include Tailwind's core styles and any custom utilities used by your host app:

```css
@tailwind base;
@tailwind components;
@tailwind utilities;

/* Example Custom Styles */
@layer utilities {
  .hdi-border {
    border-color: #473191;
  }
}
```

For the HDI Portal, copy the code highlight styles from `app/assets/stylesheets/highlightjs` into `application.tailwind.css` (this will now serve as your `input.css`). You may need to check older versions of the project to find these files.

Run the Tailwind CLI to generate a single CSS file with your custom styles:

```bash
# Replace 'hdi' with the relevant brand name if working on a different project.

$ npx tailwindcss -i input.css -o app/assets/stylesheets/hdi.tailwind.css --minify
```

Now you can reference the built CSS in your app.

```erb
<%= stylesheet_link_tag 'hdi.tailwind', 'data-turbo-track': 'reload' %>
```

Or in the Engine:

```css
@import 'hdi.tailwind'
```

## Contributing
Contribution directions go here.

Created using:
```bash
rails plugin new design_system -MOC --skip-system-test --full --no-mountable
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
