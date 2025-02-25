import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-activity"
export default class extends Controller {
  static values = {url: String}

  connect() {
    // set spot active true
    console.log("connect user activity");

    //this.updateActivity(true)
  }

  disconnect() {
    // set spot active false
    console.log("disconnect user activity");

    this.updateActivity(false)
  }

  updateActivity(activity) {
    const csrfToken = document.head.querySelector("[name~=csrf-token]").content;
    console.log("Sending PATCH request to:", this.urlValue);
    fetch(this.urlValue, {
      headers: {
        "X-CSRF-Token": csrfToken, // 👈👈👈 Set the token
        "Content-Type": "application/json"
      },
      method: 'PATCH',
      body: JSON.stringify({active: activity})
    })
  }
}
