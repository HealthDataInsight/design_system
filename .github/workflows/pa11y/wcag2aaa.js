const urls = require('./urls.json')

module.exports = {
  defaults: {
    chromeLaunchConfig: {
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
  urls
}
