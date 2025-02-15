import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="toggle-messages"
export default class extends Controller {
  static targets = ["messages", "textarea"];

  connect() {
    console.log("Connected to toggle-messages controller");
    this.messagesTarget.classList.add("d-none");
  }

  showHideMessages() {
    this.messagesTarget.classList.toggle("d-none");
    // this.textareaTarget.focus();
  }
}
