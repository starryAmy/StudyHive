import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "form" ]
  connect() {
    console.log("edit desk connect");
    console.log(this.formTarget);
  }
  edit() {
    console.log("Edit");
    this.formTarget.classList.toggle("d-none");
  }
}
