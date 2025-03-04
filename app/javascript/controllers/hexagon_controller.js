import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="hexagon"
export default class extends Controller {
  connect() {
    console.log("Connected to hexagon controller");
    this.arrangeHexagons();
  }

  arrangeHexagons() {
    const hexagons = this.element.querySelectorAll(".hex-card");
    const hexWidth = 360; // Example width of hex card
    const hexHeight = (Math.sqrt(3) / 2) * hexWidth;

    hexagons.forEach((hex, index) => {
      const row = Math.floor(index / 4); // Change 5 to number of hexes per row
      const col = index % 4;

      const x = col * (hexWidth * 0.75); // 75% of width for staggered effect
      const y = row * hexHeight + (col % 2 === 1 ? hexHeight / 2 : 0); // Offset odd columns

      hex.style.position = "absolute";
      hex.style.left = `${x}px`;
      hex.style.top = `${y}px`;
    });
  }
}
