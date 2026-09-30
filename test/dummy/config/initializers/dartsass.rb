Rails.application.config.dartsass.builds = {
  'application.scss' => 'application.css',
  'govuk.scss' => 'govuk.css',
  'nhsuk.scss' => 'nhsuk.css'
}
# dartsass-rails 0.5.1+ expects build_options as an array of arguments
# (0.5.0 and earlier took a single string).
Rails.application.config.dartsass.build_options = ['--style=expanded']
