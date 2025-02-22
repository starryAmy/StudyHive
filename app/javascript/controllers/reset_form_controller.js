import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reset-form"
export default class extends Controller {
  connect() {
    console.log("connect");

  }
  reset() {
    this.element.reset()
    console.log("hello");
  }

  submit(event) {
    event.preventDefault()
    this.element.requestSubmit() // Submits the form programmatically
  }
}
