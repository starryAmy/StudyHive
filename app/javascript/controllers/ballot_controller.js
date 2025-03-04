import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "message"]

  submit(event) {
    event.preventDefault(); // 阻止預設表單提交

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
        form.classList.add("d-none"); // 隱藏表單
        this.messageTarget.innerText = "✅ You have already voted"; // 顯示訊息
      } else {
        alert("投票失敗，請重試！");
      }
    })
    .catch(error => console.error("Error:", error));
  }
}
