import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["canvas"];

  connect() {
    console.log("Blackboard controller connected");
    this.setupCanvas();
  }

  setupCanvas() {
    const canvas = this.canvasTarget;
    if (!canvas) return;

    const ctx = canvas.getContext("2d");

    //loading blackboard pic
    const img = new Image();
    img.src = this.element.dataset.blackboardImageUrl;
    img.onload = () => {
      // keep the aspect ratio of the image
      const aspectRatio = img.width / img.height;

      // setting canvas width and height to match the image
      const containerWidth = canvas.parentElement.clientWidth;
      canvas.width = containerWidth;
      canvas.height = containerWidth / aspectRatio;
      ctx.drawImage(img, 0, 0, canvas.width, canvas.height);

       // default canvase setting
      const cols = 4;
      const rows = 4;
      const paddingUp = 180;
      const paddingDown = 180;
      const paddingLeft = 0;
      const paddingRight = 200;
      const cellWidth = (canvas.width - paddingLeft - paddingRight) / cols;
      const cellHeight = (canvas.height - paddingUp - paddingDown) / rows;
      const maxLineWidth = cellWidth - 10;
      const lineHeight = 22;

      // write time
      this.writeDate(ctx, paddingLeft, cellWidth);
      // write titles on the blackboard
      this.drawDeskTitles(ctx, cols, paddingUp, paddingLeft, cellWidth, cellHeight, maxLineWidth, lineHeight);
    }
  }

  drawDeskTitles(ctx, cols, paddingUp, paddingLeft, cellWidth, cellHeight, maxLineWidth, lineHeight){
    const titles = ["Math", "Science", "History", "Coding", "Music", "English", "Physics", "Art", "Chemistry", "Biology",
                    "Philosophy and Programming", "Geography", "Literature", "Economics", "Business", "Psychology", "Law", "Astronomy", "Engineering", "Medicine"];

    const selectedTitles = titles.sort(() => 0.5 - Math.random()).slice(0, 16);

    ctx.font = "20px Chalkduster";
    ctx.fillStyle = "white"
    ctx.textAlign = "left";

    selectedTitles.forEach((title, index) => {
      const col = index % cols; // 計算列數
      const row = Math.floor(index / cols); // 計算行數

      let x = paddingLeft + col * cellWidth + cellWidth / 2; // horizontal center
      let y = paddingUp + row * cellHeight + cellHeight / 2; // vertical center
      // **處理過長標題，自動換行**
      this.wrapText(ctx, title, x, y, maxLineWidth, lineHeight);
    });
  }

  writeDate(ctx, paddingLeft, cellWidth){
    ctx.font = "40px 'Fredericka the Great', cursive";
    ctx.fillStyle = "white"
    ctx.textAlign = "left";
    const week = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    const month = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    const date = week[new Date().getDay()] + ", " + new Date().getDate() + " " + month[new Date().getMonth()] + " " + new Date().getFullYear();

    ctx.fillText(date, paddingLeft + cellWidth / 2, 150);
  }

  wrapText(ctx, text, x, y, maxWidth, lineHeight) {
    const words = text.split(" "); // split the text into words
    let line = "";
    let lines = [];

    words.forEach((word) => {
    const testLine = line + (line ? " " : "") + word; // first, try to add the word to the current line
    const metrics = ctx.measureText(testLine);
    if (metrics.width > maxWidth && line.length > 0) {
      lines.push(line); // if the line is too long, push the current line to the lines array
      line = word; // and start a new line with the current word
    } else {
      line = testLine; // if the line is not too long, add the word to the current line
    }
    });

    lines.push(line); // push the last line to the lines array

    // draw the lines on the canvas
    let startY = y - ((lines.length - 1) * lineHeight) / 2; // draw the text vertically centered
    lines.forEach((line, i) => {
      ctx.fillText(line, x, startY + i * lineHeight);
    });
    }
}
