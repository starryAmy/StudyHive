import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="youtube"
export default class extends Controller {
  static values = { videoId: String };

  connect() {
    console.log("Stimulus YouTube controller connected.");
    this.loadYoutubeAPI();
  }

  loadYoutubeAPI() {
    if (window.YT && window.YT.Player) {
      this.createPlayer();
    } else {
      // Ensure we only define this once globally
      if (!window.onYouTubeIframeAPIReady) {
        window.onYouTubeIframeAPIReady = () => {
          document.dispatchEvent(new Event("youtubeAPIReady"));
        };
      }

      document.addEventListener("youtubeAPIReady", () => this.createPlayer(), {
        once: true,
      });

      // Check if the script is already added
      if (
        !document.querySelector(
          'script[src="https://www.youtube.com/iframe_api"]'
        )
      ) {
        let script = document.createElement("script");
        script.src = "https://www.youtube.com/iframe_api";
        script.async = true;
        document.head.appendChild(script);
      }
    }
  }

  createPlayer() {
    if (typeof YT === "undefined" || !YT.Player) {
      console.error("YT API not loaded yet.");
      return;
    }

    console.log("Creating YouTube Player...");

    // Ensure the element has an ID
    if (!this.element.id) {
      this.element.id = `youtube-player-${Math.random()
        .toString(36)
        .substr(2, 9)}`;
    }

    this.player = new YT.Player(this.element.id, {
      height: "200",
      width: "400",
      videoId: this.videoIdValue,
      playerVars: {
        autoplay: 0,
        controls: 1,
        modestbranding: 1,
      },
      events: {
        onReady: this.onPlayerReady.bind(this),
        onStateChange: this.onPlayerStateChange.bind(this),
      },
    });
  }

  onPlayerReady(event) {
    this.player = event.target;
    event.target.playVideo();
    console.log("YouTube Player Ready!", this.player);
  }

  onPlayerStateChange(event) {
    // if (!this.player || typeof this.player.getCurrentTime !== "function") {
    //   console.log(this.player);
    //   console.log(event);
    //   console.error("Player is not initialized correctly.");
    //   return;
    // }

    console.log("Player state changed:", event.data);

    switch (event.data) {
      case YT.PlayerState.UNSTARTED:
        console.log("Player is unstarted.");
        break;
      case YT.PlayerState.PLAYING:
        console.log("Player is playing.");
        break;
      case YT.PlayerState.PAUSED:
        console.log("Player is paused.");
        break;
      case YT.PlayerState.ENDED:
        console.log("Player has ended.");
        break;
      case YT.PlayerState.BUFFERING:
        console.log("Player is buffering.");
        break;
      case YT.PlayerState.CUED:
        console.log("Player is cued.");
        break;
      default:
        console.log("Unknown player state:", event.data);
    }

    // Get the current time when playing or paused
    if (
      event.data === YT.PlayerState.PLAYING ||
      event.data === YT.PlayerState.PAUSED
    ) {
      let currentTime = this.player.getCurrentTime();
      console.log("Current time:", currentTime);
    }
  }
}

// import { Controller } from "@hotwired/stimulus";

// // Connects to data-controller="youtube"
// export default class extends Controller {
//   static values = { videoId: String };

//   connect() {
//     console.log("Hello, Stimulus!" + this.element.innerHTML);
//     this.loadYoutubeAPI();
//   }

//   loadYoutubeAPI() {
//     if (window.YT) {
//       this.createPlayer();
//     } else {
//       let script = document.createElement("script");
//       script.src = "https://www.youtube.com/iframe_api";
//       script.onload = () => this.createPlayer();
//       document.head.appendChild(script);
//     }
//   }

//   createPlayer() {
//     if (typeof YT !== "undefined" && YT.Player) {
//       this.player = new YT.Player(this.element, {
//         height: "200",
//         width: "400",
//         videoId: this.videoIdValue,
//         playerVars: {
//           autoplay: 0,
//           controls: 1,
//           modestbranding: 1,
//         },
//         events: {
//           onReady: this.onPlayerReady.bind(this),
//           onStateChange: this.onPlayerStateChange.bind(this),
//         },
//       });
//     } else {
//       window.onYouTubeIframeAPIReady = () => this.createPlayer();
//     }
//   }

//   onPlayerReady(event) {
//     console.log("Player is ready");
//   }

//   onPlayerStateChange(event) {
//     let currentTime = this.player.getCurrentTime();

//     if (event.data === YT.PlayerState.PLAYING) {
//       console.log(`Video Played at ${currentTime}s`);
//       this.broadcastEvent("play", currentTime);
//     } else if (event.data === YT.PlayerState.PAUSED) {
//       console.log(`Video Paused at ${currentTime}s`);
//       this.broadcastEvent("pause", currentTime);
//     } else if (event.data === YT.PlayerState.BUFFERING) {
//       console.log(`User is seeking. Current time: ${currentTime}s`);
//       this.broadcastEvent("seek", currentTime);
//     }
//   }

//   broadcastEvent(action, time) {
//     console.log(`Broadcasting: ${action} at ${time}s`);
//     // Next step: Send this data via ActionCable (Step 3)
//   }
// }
