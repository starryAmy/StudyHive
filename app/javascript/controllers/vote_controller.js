import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["heart"];

  toggle(event) {
    event.preventDefault();
    const heartIcon = this.heartTarget;
    const url = event.currentTarget.href;

    fetch(url, {
      method: "POST",
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        "Accept": "application/json"
      }
    })
    .then(response => response.json())
    .then(data => {
      if (data.liked) {
        heartIcon.classList.remove("far");
        heartIcon.classList.add("fas");
        heartIcon.style.color = "red";
      } else {
        heartIcon.classList.remove("fas");
        heartIcon.classList.add("far");
        heartIcon.style.color = "";
      }
    });
  }
}
