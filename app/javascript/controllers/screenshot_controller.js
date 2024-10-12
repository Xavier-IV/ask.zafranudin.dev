import { Controller } from "@hotwired/stimulus";
import html2canvas from "html2canvas";

// Connects to data-controller="screenshot"
export default class extends Controller {
  static targets = ["result", "button"];

  connect() {}

  takeScreenshot() {
    // Hide the screenshot button temporarily
    this.buttonTarget.style.display = "none";

    // Take screenshot of the specific element
    this.element.onselectstart = function () {
      return false;
    };

    html2canvas(this.element).then(
      (canvas) => {
        this.resultTarget.innerHTML = "";
        // canvas.addEventListener("selectstart", () => false);
        this.resultTarget.appendChild(canvas);

        // Optionally trigger a download
        const link = document.createElement("a");
        link.download = "screenshot.png";
        link.href = canvas.toDataURL();
        link.click();

        // Show the button again after the screenshot is taken
        this.buttonTarget.style.display = "";
      },
      { scale: 1.1 },
    );
  }
}
