import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="toggle-form"
export default class extends Controller {
  static targets = ["form", "textarea"];

  connect() {
    this.formTarget.classList.add("d-none");
  }

  showHideForm() {
    this.formTarget.classList.toggle("d-none");
    this.textareaTarget.focus();
  }
}
