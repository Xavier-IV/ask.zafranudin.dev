import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="turnstile"
export default class extends Controller {
  static values = { widgetId: String };

  connect() {
    console.log("Turnstile Stimulus controller connected");
    if (typeof turnstile !== "undefined") {
      console.log(turnstile);
    }
  }

  resetTurnstile() {
    console.log("Resetting turnstile");
    if (typeof turnstile !== "undefined") {
      turnstile.reset();
    }
  }
}
