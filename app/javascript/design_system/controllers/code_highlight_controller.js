import { Controller } from '@hotwired/stimulus'
import hljs from 'highlight.js'

// Connects to data-controller="code-highlight"
export default class extends Controller {
  connect () {
    hljs.highlightElement(this.element)
  }
}
