import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results", "section"]
  static values = { apikey: String }

  connect() {
    console.log("Connected to Giphy Controller!");
    this.apiKey = "cS1lJwcd2yJlGx5VSelAq0y7fctvJ8pe";
    console.log("API Key:", this.apikeyValue);
    this.endpoint = "https://api.giphy.com/v1/gifs/search";
  }
  open() {
    this.inputTarget.classList.toggle("d-none");
    console.log("Open Giphy Controller!");
  }

  search() {
    const query = this.inputTarget.value;
    console.log("Searching for", query);
    if (!query.trim()) return;

    fetch(`${this.endpoint}?api_key=${this.apiKey}&q=${query}&limit=10`)
      .then(response => response.json())
      .then(data => {
        console.log(data);
        this.resultsTarget.innerHTML = data.data
          .map(gif => `
            <img src="${gif.images.fixed_height.url}"
                 alt="GIF"
                 class="giphy-result"
                 data-url="${gif.images.original.url}"
                 data-action="click->giphy#insertGif">
          `).join('');
      });
  }

  insertGif(event) {
    const chatInput = document.getElementById("msg_content");
    if (!chatInput) {
      console.error("Chat input not found!");
      return;
    }
    chatInput.value = event.currentTarget.dataset.url;
    chatInput.form.submit();
  };
}
