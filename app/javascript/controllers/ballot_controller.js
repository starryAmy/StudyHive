import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "message"]

  submit(event) {
    event.preventDefault();

    const form = this.formTarget;
    const formData = new FormData(form);

    fetch(form.action, {
      method: "POST",
      body: formData,
      headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      }
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        form.classList.add("d-none");
        this.messageTarget.innerText = "✅ You have already voted";
      } else {
        alert("投票失敗，請重試！");
      }
    })
    .catch(error => console.error("Error:", error));
  }
}
