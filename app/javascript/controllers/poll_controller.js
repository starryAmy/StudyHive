import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["pollform"]
  connect() {
    console.log("PollController connected!");
  }

  toggle() {
    this.pollformTarget.classList.toggle("d-none");
  }

}
