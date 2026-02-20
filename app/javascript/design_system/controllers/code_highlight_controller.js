import { Controller } from '@hotwired/stimulus'
import hljs from '/design_system/static/highlightjs-11.11.1/highlight.min.js'

// Connects to data-controller="code-highlight"
export default class extends Controller {
  connect () {
    hljs.highlightElement(this.element)
  }
}
