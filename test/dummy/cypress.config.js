const { defineConfig } = require('cypress')

module.exports = defineConfig({
  e2e: {
    baseUrl: 'http://localhost:3000', // DevSKIM: ignore DS137138
    setupNodeEvents (on, config) {
      // implement node event listeners here
    }
  },
  screenshotsFolder: 'tmp/cypress_screenshots',
  videosFolder: 'tmp/cypress_videos',
  trashAssetsBeforeRuns: false
})
