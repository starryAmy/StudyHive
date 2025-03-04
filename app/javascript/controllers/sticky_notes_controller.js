import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="sticky-notes"
export default class extends Controller {
  connect() {
    console.log("Sticky notes controller connected");
    this.randomStickyNotes();
  }

  randomStickyNotes() {
    const colors = [
      "lightblue",
      "lightgreen",
      "yellow",
      "orange",
      "pink",
      "lavender",
      "lightcoral",
    ];
    const container = this.element;
    const notes = container.querySelectorAll(".sticky-note");

    const containerHeight = container.clientHeight;
    let currentX = 0; // Start placing notes from the leftmost position

    notes.forEach((note) => {
      const messageContent = note.querySelector(
        "[data-sticky-note-target='message-content']"
      );

      if (messageContent) {
        let text = messageContent.textContent.trim();
        const maxLength = 18; // Set character limit
        if (text.length > maxLength) {
          messageContent.textContent = text.substring(0, maxLength) + "...";
        }
      }

      // Random vertical position (within container height)
      const randomY = Math.random() * (containerHeight - note.clientHeight);
      const randomRotation = Math.random() * 20 - 10; // Rotation between -10 and 10 degrees

      // Apply styles
      note.style.position = "absolute";
      note.style.left = `${currentX}px`; // Incrementally place notes horizontally
      note.style.top = `${randomY}px`; // Random vertical positioning
      note.style.transform = `rotate(${randomRotation}deg)`;
      note.style.backgroundColor =
        colors[Math.floor(Math.random() * colors.length)];

      note.addEventListener("mouseenter", () => {
        note.style.transition = "transform 0.2s ease-in-out"; // Ensure transition only applies to scale
        note.style.transform = `scale(1.2) rotate(${randomRotation}deg)`;
      });

      note.addEventListener("mouseleave", () => {
        note.style.transition = "transform 0.2s ease-in-out"; // Keep transition only for scale
        note.style.transform = `scale(1) rotate(${randomRotation}deg)`; // Reset scale smoothly, keep rotation unchanged
      });

      currentX += note.clientWidth; // Move next note to the right
    });
  }
}
