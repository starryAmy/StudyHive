import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reset-form"
export default class extends Controller {
  connect() {
    console.log("connect");
  }
  reset() {
    this.element.reset()
    console.log("hello");
  }

  submit(event) {
    event.preventDefault()
    this.element.requestSubmit() // Submits the form programmatically
  }

  updateLastOnline() {
    fetch("/update_user_last_online", {
      method: "POST",
      headers: {
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
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
    this.pollingInterval = setInterval(() => this.updateLastOnline(), 2000);
  }
}
