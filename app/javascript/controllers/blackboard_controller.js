import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Blackboard controller connected");
    this.displayDate();
    this.fetchFollowedUsersStatus();
  }

  displayDate() {
    const container = this.element;
    const dateText = document.createElement("div");
    dateText.classList.add("blackboard-date");
    dateText.textContent = this.getFormattedDate();

    container.appendChild(dateText);
  }

  getFormattedDate() {
    const week = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    const month = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    const date = new Date();

    return `${week[date.getDay()]}, ${date.getDate()} ${month[date.getMonth()]} ${date.getFullYear()}`;
  }

  fetchFollowedUsersStatus() {
    fetch("/followed_users_status")
      .then(response => response.json())
      .then(data => {
        // Check if the data is a hash and has elements
        if (Array.isArray(data) && data.length > 0) {
          this.displayUsersOnBlackboard(data);
        }
      })
      .catch(error => console.error("Error fetching status:", error));
  }

  displayUsersOnBlackboard(users) {
    // this.element is the controller element
    const container = this.element;
    // remove all existing user and room links before adding new ones
    container.querySelectorAll(".blackboard-user, .blackboard-room-link, .blackboard-room-link-not-in-room").forEach(el => el.remove());

    users.forEach((user, index) => {
      const y = 80 + index * 40;

      const userText = document.createElement("div");
      userText.classList.add("blackboard-user");
      userText.style.top = `${y}px`;
      userText.textContent = `${user.name} - ${user.online ? "🟢 Online" : `🔴 Offline (Last seen: ${this.formatDate(user.last_online_at)})`}`;
      container.appendChild(userText);

      if (user.online && user.spots.length > 0) {
          const roomLink = document.createElement("a");
          roomLink.href = `/rooms/${user.spots[0].room_id}`;
          roomLink.textContent = `in ${user.spots[0].room_status} Room: ${user.spots[0].room}`;
          roomLink.classList.add("blackboard-room-link");
          userText.appendChild(roomLink);
      } else if (user.online && user.spots.length === 0) {
        const roomLink = document.createElement("div");
        roomLink.textContent = "but not in any rooms right now";
        roomLink.classList.add("blackboard-room-link-not-in-room");
        userText.appendChild(roomLink);
      }
    });
  }

  formatDate(timestamp) {
    if (!timestamp) return "Unknown";
    const date = new Date(timestamp);
    return date.toLocaleString();
  }
}
