const urls = require('./urls.json')

// Pages where axe reports a false-positive color-contrast issue: the NHS radio/checkbox
// control is drawn with a ::before/::after pseudo element on the label, so axe cannot
// determine the label's background and bails out. The label text itself passes AA.
// Revisit this ignore whenever the nhsuk/govuk frontend gems or pa11y-ci are bumped (#281)
// in case a newer axe/component version resolves it. Last confirmed still firing with
// nhsuk-frontend 10.3.1, govuk-frontend 5.11.1, pa11y-ci 5.0.0 (axe-core 4.13.0).
const contrastFalsePositivePaths = [
  '/assistants/new',
  '/components/checkboxes',
  '/components/radios'
]

const urlsWithIgnores = urls.map((url) =>
  contrastFalsePositivePaths.some((path) => url.endsWith(path))
    ? { url, ignore: ['color-contrast'] }
    : url
)

module.exports = {
  defaults: {
    chromeLaunchConfig: {
      executablePath: process.env.CHROME_PATH,
      args: [
        '--no-sandbox',
        '--disable-setuid-sandbox',
        '--disable-dev-shm-usage'
      ]
    },
    runners: [
      'axe'
    ],
    standard: 'WCAG2AA'
  },
  urls: urlsWithIgnores
}
