import { Controller } from '@hotwired/stimulus'

// Define the Stimulus controller that shows and hides the sidebar menu
export default class extends Controller {
  // We are interacting with the menuTarget element with the `data-sidebar-target="menu"` attribute.
  static targets = ['menu']

  // The show method is designed to display the menu by removing the
  // "hidden" class and adding "opacity-100".
  show (event) {
    const menuClassList = this.menuTarget.classList

    // Remove the 'hidden' class to make the menu visible
    menuClassList.remove('hidden')

    // This delay is used to ensure that the CSS transition can be triggered.
    setTimeout(function () {
      // Add the 'opacity-100' class after no delay, which will trigger a fade-in effect.
      menuClassList.add('opacity-100')
    }, 0)
  }

  // The hide method will fade out the menu by removing the
  // "opacity-100" class and adding "hidden" after a transition delay.
  hide () {
    const menuClassList = this.menuTarget.classList

    // Remove the 'opacity-100' class to start the fade-out effect
    menuClassList.remove('opacity-100')

    // This delay is just longer than the time it may take for the fade-out transition to complete.
    setTimeout(function () {
      // Add the 'hidden' class after the fade-out transition completes,
      // which hides the menu entirely.
      menuClassList.add('hidden')
    }, 310)
  }
}
