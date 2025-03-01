import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="text-area"
export default class extends Controller {
  static values = { url: String }

  connect() {
    console.log("text-area connected");
  }

  deselect(event) {
    const content = event.target.value;
    console.log("content:", content);
    console.log("url", this.urlValue);

    fetch(this.urlValue, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.head.querySelector("[name~=csrf-token]").content
      },
      body: JSON.stringify({ room: { resources_content: content } })
    }).then(response => {
        console.log(response.ok);
      })
  }
}
