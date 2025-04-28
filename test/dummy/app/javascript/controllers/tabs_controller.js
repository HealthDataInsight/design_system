// app/javascript/controllers/tabs_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tabButton", "tabPanel"]

  show(event) {
    event.preventDefault()

    const selectedButton = event.currentTarget
    const targetPanelId = selectedButton.getAttribute("aria-controls")

    // Update all tab buttons
    this.tabButtonTargets.forEach((button) => {
      const isSelected = button === selectedButton
      button.classList.toggle("hdi-tabs__tab--selected", isSelected)
      button.setAttribute("aria-selected", isSelected.toString())
    })

    // Update all tab panels
    this.tabPanelTargets.forEach((panel) => {
      const isActive = panel.id === targetPanelId
      panel.classList.toggle("hdi-tabs__panel--hidden", !isActive)
    })
  }
}
