import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["heart", "count"];

  toggle(event) {
    console.log(event);
    event.preventDefault();
    const heartIcon = this.heartTarget;
    console.log(heartIcon);
    let liked = heartIcon.dataset.liked === "true"
    let chatmessageId = heartIcon.dataset.chatmessageid;
    console.log("liked: " + liked);

    fetch(`/votes?chatmessage_id=${chatmessageId}`, {
      method: liked ? "DELETE" : "POST",
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        "Accept": "application/json"
      },
    })
    .then(response => response.json())
    .then(data => {
      if (data.liked) {
        console.log("liked");
        heartIcon.classList.remove("far");
        heartIcon.classList.add("fas");
        heartIcon.style.color = "red";
      } else {
        console.log("unliked");
        heartIcon.classList.remove("fas");
        heartIcon.classList.add("far");
        heartIcon.style.color = "blue";
      }
      this.countTarget.textContent = data.likes;
      heartIcon.dataset.liked = data.liked;
      console.log(data.liked);
    });
  }
}
