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

These need to be copied to the [assets folder](../app/assets/stylesheets/design_system/static/govuk-frontend-5.3.1), retaining the folder structure.

### Javascript

The javascript files are located in ./packages/govuk-frontend/dist/govuk/:
- govuk-frontend.min.js
- govuk-frontend.min.js.map

These need to be copied to the [public folder](../public/design_system/static/govuk-frontend-5.3.1)

### Other Assets
All files in the repo's ./packages/govuk-frontend/dist/govuk/assets folder need to be copied to the [public folder](../public/design_system/static/govuk-frontend-5.3.1), again retaining the folder structure.

### Layout
The [layout file](../app/views/layouts/govuk.html.erb) will need to be updated to change version numbers of links, etc.

## NHSUK Frontend (currently v9.1.0)
To update NHSUK Frontend, run `bundle exec rake app:update_nhs_frontend\[9.3.0\]` in the terminal (replace '9.3.0' with your desired version).

## NDRSUK Frontend (currently v8.1.1)
To update NDRSUK Frontend, run `bundle exec rake app:update_ndrs_frontend\[9.3.0\]` in the terminal (replace '9.3.0' with your desired version). This will edit and rename files as required. There is additional information in the repo's README.md.
