import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["section"];

  connect() {
    console.log("invite controller connected");
  }

  toggle() {
    this.sectionTarget.classList.toggle("d-none");
  }
  disable(e) {
    e.preventDefault();
    e.currentTarget.disabled = true;
    e.currentTarget.innerText = "Invited!";
  }
}
