// app/javascript/controllers/clipboard_controller.js
import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['source', 'buttonText']

  // Copies the selected text to the clipboard.
  copy () {
    if (navigator.clipboard && this.hasSourceTarget) {
      // The selected text to be copied.
      const copytext = this.sourceTarget.value || this.sourceTarget.innerText

      navigator.clipboard.writeText(copytext)
        .then(() => {
        // Fired when the text is successfully copied to the clipboard.
          this.showCopiedMessage()
        }).catch(err => {
        // Fired if an error occurs while copying the text to the clipboard.
          console.error('Failed to copy text: ', err)
        })
    } else {
      // Fired if the Clipboard API is not available or the source target is missing.
      console.error('Clipboard API not available or source target missing')
    }
  }

  showCopiedMessage () {
    // The text to be displayed in the button.
    this.buttonTextTarget.textContent = 'Copied!'

    // The time interval after which the button text should be reset to "Copy".
    const resetInterval = 2000

    // Resets the button text to "Copy" after the specified time interval.
    const resetButtonText = () => {
      this.buttonTextTarget.textContent = 'Copy'
    }

    setTimeout(resetButtonText, resetInterval)
  }
}
