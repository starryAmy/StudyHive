import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "clickable-card"]
  connect() {
    console.log("MessageController connected!");
  }

  toggle(e){
    let deskID = e.target.dataset.deskId;
    let form = this.formTargets.find(f => f.dataset.deskId == deskID);
    if(form){
      form.style.display = form.style.display === "none" ? "block" : "none";
    }
  }

  toIndividualDesk(){
    window.location.href = this.element.dataset.url
  }
}
