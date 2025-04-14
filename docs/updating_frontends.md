# Updating Frontends

## GOVUK Frontend (currently v5.3.1)
```bash
# Automatically fetch the latest
bundle exec rake app:make_govuk

# Update to a specific version
bundle exec rake app:make_govuk\[5.9.0\]
```

## NHSUK Frontend (currently v9.1.0)
```bash
# Automatically fetch the latest
bundle exec rake app:make_nhsuk

# Update to a specific version
bundle exec rake app:make_nhsuk\[9.3.0\]
```

## NDRSUK Frontend (currently v8.1.1)
```bash
# NDRSUK Version number must be explicitly specified (no 'latest' support)
bundle exec rake app:make_nhsuk\[9.3.0\]
```
There is additional information in the [ndrsuk-frontend repo](https://github.com/HealthDataInsight/ndrsuk-frontend)'s README.md.
