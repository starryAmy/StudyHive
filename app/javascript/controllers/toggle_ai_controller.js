import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="toggle-ai"
export default class extends Controller {
  connect() {
    console.log("Connected to toggle-ai controller");
    this.messagesTarget.classList.add("d-none");
  }

  showHideMessages() {
    this.messagesTarget.classList.toggle("d-none");
  }
}
