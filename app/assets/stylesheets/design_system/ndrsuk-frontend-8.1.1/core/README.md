# Core

Core contains all the building blocks (page layout and the responsive grid) and fundamental styles (such as colours and typography) needed for NHS websites and services. These styles are required for all of the components to work.

Core also is the home of powerful `sass` features such as variables, mixins, functions and maps.

## Page layout

### Fixed-width container

```html
<div class="ndrsuk-width-container">
  <main class="ndrsuk-main-wrapper" id="maincontent">
    <!-- Grid items -->
  </main>
</div>
```

### Fluid-width container

```html
<div class="ndrsuk-width-container-fluid">
  <main class="ndrsuk-main-wrapper" id="maincontent">
    <!-- Grid items -->
  </main>
</div>
```

## Grid items

### Full width

```html
<div class="ndrsuk-grid-row">
  <div class="ndrsuk-grid-column-full">
    <!-- Component -->
  </div>
</div>
```

### Three-quarters

```html
<div class="ndrsuk-grid-row">
  <div class="ndrsuk-grid-column-three-quarters">
    <!-- Component -->
  </div>
</div>
```

### One-half

```html
<div class="ndrsuk-grid-row">
  <div class="ndrsuk-grid-column-one-half">
    <!-- Component -->
  </div>
</div>
```

### Two-thirds

```html
<div class="ndrsuk-grid-row">
  <div class="ndrsuk-grid-column-two-thirds">
    <!-- Component -->
  </div>
</div>
```

### One-third

```html
<div class="ndrsuk-grid-row">
  <div class="ndrsuk-grid-column-one-third">
    <!-- Component -->
  </div>
</div>
```

### One-quarter

```html
<div class="ndrsuk-grid-row">
  <div class="ndrsuk-grid-column-one-quarter">
    <!-- Component -->
  </div>
</div>
```

### Nested grid items

```html
<div class="ndrsuk-grid-row">
  <div class="ndrsuk-grid-column-two-thirds">
    <!-- Component -->
    <div class="ndrsuk-grid-row">
      <div class="ndrsuk-grid-column-one-half">
        <!-- Component -->
      </div>
      <div class="ndrsuk-grid-column-one-half">
        <!-- Component -->
      </div>
    </div>

  </div>
</div>
```

### Example page layout

```html
<!-- Header -->
<div class="ndrsuk-width-container">
  <main class="ndrsuk-main-wrapper" id="maincontent">
    <div class="ndrsuk-grid-row">
      <div class="ndrsuk-grid-column-three-quarters">
        <!-- Components -->
      </div>
    </div>
  </main>
</div>
<!-- Footer -->
```

## Utilities

### Clearfix

Automatically clear an elements child elements.

```html
<div class="ndrsuk-u-clear"></div>
```

### Bold font weight

```html
<p class="ndrsuk-u-font-weight-bold"></p>
```

### Grid overrides

By default all grid elements will go to 100% width on screen sizes below tablet. These utilities can force
custom widths on all screen sizes.

```
ndrsuk-u-[grid-size]
```

```html
<div class="ndrsuk-grid-column-one-half ndrsuk-u-one-half"></div>
```

### Normal font weight

```html
<p class="ndrsuk-u-font-weight-normal"></p>
```

### Secondary text colour

```html
<p class="ndrsuk-u-secondary-text-color"></p>
```

### Reading width

Add a maximum width to large pieces of content, to improve readability.

```html
<div class="ndrsuk-u-reading-width">
  <!-- Component -->
</div
```

### Remove top and bottom margins

```html
<h1 class="ndrsuk-u-top-and-bottom"></h1>
```

### Spacing overrides

```html
class="ndrsuk-u-margin-[direction]-[spacing]"
```

#### Remove bottom margin

```html
<h1 class="ndrsuk-u-margin-bottom-0"></h1>
```

#### Remove all margins

```html
<h1 class="ndrsuk-u-margin-0"></h1>
```

#### Custom margins

```html
<h1 class="ndrsuk-u-margin-top-1"></h1>
```

### Prevent text wrapping

Prevent long anchor links from line breaking on smaller screens.

```html
<a class="ndrsuk-u-nowrap"></a>
```

### Visually hidden

Hide elements visually but keep it in the DOM, useful for screen readers.

```html
<span class="ndrsuk-u-visually-hidden"></span>
```

## Typography

### Lede text

```html
<h1>Live Well</h1>
<p class="ndrsuk-lede-text">Advice, tips and tools to help you make the best choices about your health and wellbeing.</p>
```

### Font

The default `@font-face`, "Frutiger", is loaded from `https://assets.nhs.uk`. The host for the fonts can be
overridden or disabled entirely.

NHS England has a licence for the Frutiger webfont that the NHS website team can use. All other NHS England teams and other NHS organisations **must** have their own licence with Monotype.

- `$ndrsuk-fonts-path`: base URL to load fonts from (e.g. `/fonts/`; trailing slash required)
- `$ndrsuk-include-font-face`: set to false to disable the inclusion of the `@font-face` definition entirely

## Breakpoints

```
mobile: 320px
tablet: 641px
desktop: 769px
large-desktop: 990px
```

### Media queries (using [sass-mq](https://github.com/sass-mq/sass-mq))

`mq()` is a Sass mixin that helps you compose media queries in an elegant way.

`mq()` takes up to three optional parameters:

- `$from`: inclusive `min-width` boundary
- `$until`: exclusive `max-width` boundary
- `$and`: additional custom directives

```scss
.responsive {
  // Apply styling to mobile and upwards
  @include mq($from: mobile) {
    color: red;
  }
  // Apply styling up to devices smaller than tablets (exclude tablets)
  @include mq($until: tablet) {
    color: blue;
  }
  // Same thing, in landscape orientation
  @include mq($until: tablet, $and: '(orientation: landscape)') {
    color: green;
  }
  // Apply styling to print media
  @include mq($media-type: print) {
    color: orange;
  }
}
```

## Colour variables

### Primary

```scss
$color_ndrsuk-blue: #218183;
$color_ndrsuk-white: #ffffff;
$color_ndrsuk-black: #212b32;
$color_ndrsuk-green: #007f3b;
$color_ndrsuk-red: #da291c;
$color_ndrsuk-yellow: #ffeb3b;
$color_ndrsuk-purple: #330072;
```

### Secondary

```scss
$color_ndrsuk-pale-yellow: #fff9c4;
$color_ndrsuk-warm-yellow: #ffb81C;
$color_ndrsuk-aqua-green: #00A499;
```

### Greyscale

```scss
$color_ndrsuk-grey-1: #425563;
$color_ndrsuk-grey-2: #768692;
$color_ndrsuk-grey-3: #aeb7bd;
$color_ndrsuk-grey-4: #d8dde0;
$color_ndrsuk-grey-5: #f0f4f5;
```
