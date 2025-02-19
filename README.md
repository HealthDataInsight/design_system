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

## Contributing
Contribution directions go here.

Created using:
```bash
rails plugin new design_system -MOC --skip-system-test --full --no-mountable
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
