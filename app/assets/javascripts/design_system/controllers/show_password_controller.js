import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'password' , 'button']

  toggle () {
    if (this.passwordTarget.type === 'password') {
      this.passwordTarget.type = 'text'
	    this.buttonTarget.textContent = 'Hide password'
    } else {
      this.passwordTarget.type = 'password'
	    this.buttonTarget.textContent = 'Show password'
    }
  }
}
