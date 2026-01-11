import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bingo"
export default class extends Controller {
  static targets = ["number", "checkbox"]

  spin() {
    if (this.hasCheckboxTarget && this.checkboxTarget.checked) {
      return
    }

    this.stop() // Clear any existing interval

    // Reset styles
    this.numberTarget.classList.remove("text-amber-500", "scale-125", "transition-transform", "duration-500", "ease-out")
    this.numberTarget.classList.add("text-indigo-600")

    this.interval = setInterval(() => {
      const randomNum = Math.floor(Math.random() * 75) + 1
      this.numberTarget.textContent = randomNum
    }, 50)
  }

  stop() {
    if (this.interval) {
      clearInterval(this.interval)
      this.interval = null
    }
  }

  numberTargetDisconnected() {
    this.stop()
  }

  disconnect() {
    this.stop()
  }
}
