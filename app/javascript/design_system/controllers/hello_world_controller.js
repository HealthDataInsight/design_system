import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['name', 'greeting']

  connect () {
    console.log('Hello from the Design System!')
  }

  greet () {
    this.greetingTarget.textContent = `Hello, ${this.nameTarget.value}!`
  }
}
