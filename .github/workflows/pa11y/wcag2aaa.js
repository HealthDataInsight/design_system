const urls = require('./urls.json')

// Pages where axe reports a false-positive contrast issue: the NHS radio/checkbox control
// is drawn with a ::before/::after pseudo element on the label, so axe cannot determine the
// label's background and bails out. The label text itself passes. Revisit this ignore
// whenever the nhsuk/govuk frontend gems are bumped (see the tracking ticket) in case a
// newer axe/component version resolves it.
const contrastFalsePositivePaths = [
  '/assistants/new',
  '/components/checkboxes',
  '/components/radios'
]

const urlsWithIgnores = urls.map((url) =>
  contrastFalsePositivePaths.some((path) => url.endsWith(path))
    ? { url, ignore: ['color-contrast', 'color-contrast-enhanced'] }
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
    standard: 'WCAG2AAA'
  },
  urls: urlsWithIgnores
}
