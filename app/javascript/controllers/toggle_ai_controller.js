import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="toggle-ai"
export default class extends Controller {
  static targets = ["aiChat"];

  connect() {
    console.log("Connected to toggle-ai controller");
    // this.aiChatTarget.classList.add("d-none");
  }

  showHideAI() {
    this.aiChatTarget.classList.toggle("d-none");
  }
}
