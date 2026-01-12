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
    this.numberTarget.classList.remove("text-amber-500", "scale-125")
    this.numberTarget.classList.add("text-indigo-600")

    // Add recoil effect
    this.numberTarget.classList.add("scale-90")
    setTimeout(() => {
      this.numberTarget.classList.remove("scale-90")
    }, 50)


    this.interval = setInterval(() => {
      const randomNum = Math.floor(Math.random() * 75) + 1
      this.numberTarget.textContent = randomNum
    }, 25)
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
