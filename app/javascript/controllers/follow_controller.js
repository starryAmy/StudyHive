import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "followButton" ]

  toggle() {
    print ("follow controller is connected")
  }

  follow() {
    if (this.followButtonTarget.innerText == "Follow") {
      this.followButtonTarget.innerText = "Unfollow";
      this.followButtonTarget.setAttribute("data-action", "click->follow#unfollow");
    }

  }

  unfollow() {
    if (this.followButtonTarget.innerText == "Unfollow") {
      this.followButtonTarget.innerText = "Follow";
      this.followButtonTarget.setAttribute("data-action", "click->follow#follow");
    }
  }
}
