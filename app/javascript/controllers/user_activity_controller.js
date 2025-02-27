import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-activity"
export default class extends Controller {
  static values = {url: String}

  connect() {
    // set spot active true
    console.log("connect user activity");

    //this.updateActivity(true)
    this.updateLastOnline();
    this.startPolling();
  }

  disconnect() {
    // set spot active false
    console.log("disconnect user activity");
    this.updateActivity(false)
    clearInterval(this.pollingInterval);
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

  updateLastOnline() {
    fetch("/update_user_last_online", {
      method: "POST",
      headers: {
        "X-CSRF-Token": document.querySelector("[name~=csrf-token]").content,
        "Content-Type": "application/json"
      },
      body: JSON.stringify({})
    }).then(response => {
      if (response.ok) {
        console.log("Last online updated");
      }
    }).catch(error => console.error("Error updating last online:", error));
  }

  startPolling() {
    this.pollingInterval = setInterval(() => this.updateLastOnline(), 60000);
  }
}
