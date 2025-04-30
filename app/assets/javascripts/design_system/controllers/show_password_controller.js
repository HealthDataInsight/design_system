import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'password' , 'button']
  static values = {
    showContent: String,
    hideContent: String,
  }

  toggle () {
    if (this.passwordTarget.type === 'password') {
      this.passwordTarget.type = 'text'
      this.updateButtonContent(this.hideContentValue)
    } else {
      this.passwordTarget.type = 'password'
      this.updateButtonContent(this.showContentValue)
    }
  }

  updateButtonContent(content) {
    // Check if content contains HTML tags
    const hasHtml = /<[a-z][\s\S]*>/i.test(content)
    
    if (hasHtml) {
      this.buttonTarget.innerHTML = content
    } else {
      this.buttonTarget.textContent = content
    }
  }
}
