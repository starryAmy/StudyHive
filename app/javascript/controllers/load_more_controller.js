import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "container"]

  loadMore(){
    let page = parseInt(this.buttonTarget.getAttribute("data-page")) + 1;
    fetch(`/desks?page=${page}`, {
      headers: { "X-Requested-With": "XMLHttpRequest", "Accept": "text/javascript" }
    })
      .then(response => response.text()) // return HTML
      .then(html => {
        this.containerTarget.insertAdjacentHTML("beforeend", html);
        this.buttonTarget.setAttribute("data-page", page);
      })
      .catch(error => console.error("Error loading more desks:", error));
  }
}
