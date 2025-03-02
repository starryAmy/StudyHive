import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="toggle-messages"
export default class extends Controller {
  static targets = ["messages", "form"];

  connect() {
    console.log("Connected to toggle-messages controller");
    this.messagesTarget.classList.add("d-none");
    this.formTarget.classList.add("d-none");
  }

  showHideMessages() {
    this.messagesTarget.classList.toggle("d-none");
    this.formTarget.classList.toggle("d-none");
  }

  submit(event) {
    event.preventDefault();
    this.element.requestSubmit(); // Submits the form programmatically
  }
}
