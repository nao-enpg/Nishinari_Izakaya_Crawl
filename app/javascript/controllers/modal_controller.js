import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dialog"]

  close() {
    this.dialogTarget.classList.add("hidden")
  }

  open() {
    this.dialogTarget.classList.remove("hidden")
  }
}