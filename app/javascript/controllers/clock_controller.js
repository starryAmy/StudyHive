import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["time", "countdown"];
  static values = { endTime: String }; // Store end time as a data attribute

  connect() {
    this.updateTime();
    this.timer = setInterval(() => this.updateTime(), 1000);

    if (this.hasCountdownTarget) {
      this.startCountdown();
    }
  }

  disconnect() {
    clearInterval(this.timer);
    clearInterval(this.countdownTimer);
  }

  updateTime() {
    const now = new Date();
    this.timeTarget.textContent = now.toLocaleTimeString();
  }

  startCountdown() {
    const endTime = new Date(this.endTimeValue); // Read from data attribute
    this.countdownTimer = setInterval(() => {
      const now = new Date();
      const remaining = endTime - now;

      if (remaining <= 0) {
        this.countdownTarget.textContent = "Time's up!";
        clearInterval(this.countdownTimer);
      } else {
        const minutes = Math.floor((remaining / 1000 / 60) % 60);
        const seconds = Math.floor((remaining / 1000) % 60);
        this.countdownTarget.textContent = `${minutes}m ${seconds}s`;
      }
    }, 1000);
  }
}

// import { Controller } from "@hotwired/stimulus";

// // Connects to data-controller="clock"
// export default class extends Controller {
//   static targets = ["time", "timer"];
//   static values = { endTime: String };

//   connect() {
//     console.log("Hello, Stimulus!", this.element);
//     this.updateTime();
//     this.timer = setInterval(() => {
//       this.updateTime();
//     }, 1000);
//     if (this.hasTimerTarget) {
//       this.startCountDown();
//     }
//   }

//   disconnect() {
//     clearInterval(this.timer);
//     clearInterval(this.countdownTimer);
//   }

//   updateTime() {
//     const now = new Date();
//     this.timeTarget.textContent = now.toLocaleTimeString();
//   }

//   startCountDown() {
//     const endTime = new Date(this.endTimeValue);
//     this.countdownTimer = setInterval(() => {
//       const now = new Date();
//       const remaining = endTime - now;
//       if (remaining <= 0) {
//         clearInterval(this.countdownTimer);
//         this.timerTarget.textContent = "Time's up!";
//       } else {
//         const minutes = Math.floor((remaining / 1000 / 60) % 60);
//         const seconds = Math.floor((remaining / 1000) % 60);
//         this.timerTarget.tectContent = `${minutes}:${seconds}`;
//       }
//     }, 1000);
//   }
// }
