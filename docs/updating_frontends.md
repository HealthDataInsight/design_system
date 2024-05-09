# Updating Frontends

## GOVUK Frontend (currently v5.3.1)

### SCSS
The SCSS files are currently in the [downloaded repo's](https://github.com/alphagov/govuk-frontend) ./packages/govuk-frontend/dist/govuk folder. The complete list of files required from this folder is:
- ./_base.scss
- ./all.scss
- ./components/**/*
- ./core/**/*
- ./helpers/**/*
- ./objects/**/*
- ./overrides/**/*
- ./settings/**/*
- ./tools/**/*
- ./utilities/**/*
- ./vendor/**/*

These need to be copied to the [assets folder](../app/assets/stylesheets/design_system/govuk-frontend-5.3.1), retaining the folder structure.

### Javascript

The javascript files are located in ./packages/govuk-frontend/dist/govuk/:
- govuk-frontend.min.js
- govuk-frontend.min.js.map

These need to be copied to the [public folder](../public/design_system/govuk-frontend-5.3.1)

### Other Assets
All files in the repo's ./packages/govuk-frontend/dist/govuk/assets folder need to be copied to the [public folder](../public/design_system/govuk-frontend-5.3.1), again retaining the folder structure.

### Layout
The [layout file](../app/views/layouts/govuk.html.erb) will need to be updated to change version numbers of links, etc.

## NHSUK Frontend (currently v8.1.1)
The SCSS files are currently in the [downloaded repo's](https://github.com/nhsuk/nhsuk-frontend) ./packages folder. The complete list is:
- ./nhsuk.scss
- ./components/**/*
- ./core/**/*

These need to be copied to the [assets folder](../app/assets/stylesheets/design_system/nhsuk-frontend-8.1.1), retaining the folder structure.

### Javascript

The javascript file is located in the ./dist folder:
- nhsuk.min.js

It needs to be copied to the [public folder](../public/design_system/nhsuk-frontend-8.1.1) and renamed as nhsuk.min.js

### Assets
The files in the repo's ./packages/assets folder need to be copied to the [public folder](../public/design_system/nhsuk-frontend-8.1.1), again retaining the folder structure.

### Layout
The [layout file](../app/views/layouts/nhsuk.html.erb) will need to be updated to change version numbers of links, etc.

## NDRSUK Frontend (currently v8.1.1)
The SCSS files are currently in the [downloaded repo's](https://github.com/HealthDataInsight/ndrsuk-frontend) ./packages folder. After downloading, run the script in ./scripts/nhs2ndrs. This will edit and rename files as required. There is additional information in the repo's README.md. The complete list is:
- ./ndrsuk.scss
- ./components/**/*
- ./core/**/*

These need to be copied to the [assets folder](../app/assets/stylesheets/design_system/ndrsuk-frontend-8.1.1), retaining the folder structure.

### Javascript

The javascript file is located in the ./dist folder:
- ndrsuk.min.js

It needs to be copied to the [public folder](../public/design_system/ndrsuk-frontend-8.1.1) and renamed as ndrsuk.min.js

### Assets
The files in the repo's ./packages/assets folder need to be copied to the [public folder](../public/design_system/ndrsuk-frontend-8.1.1), again retaining the folder structure.

### Layout
The [layout file](../app/views/layouts/ndrsuk.html.erb) will need to be updated to change version numbers of links, etc.
