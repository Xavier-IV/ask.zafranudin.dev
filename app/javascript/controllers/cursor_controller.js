import { Controller } from "@hotwired/stimulus";
import consumer from "../channels/consumer"; // Import ActionCable consumer

// Connects to data-controller="cursor"
export default class extends Controller {
  connect() {
    console.log("Cursor tracking connected");

    // Subscribe to the PresenceChannel
    this.subscription = consumer.subscriptions.create("PresenceChannel", {
      received: (data) => {
        console.log(data);
        if (data.type === "cursor_position") {
          this.updateCursor(data.user_id, data.x, data.y);
        } else if (data.type === "user_disconnected") {
          this.removeCursor(data.user_id);
        }
      },
    });

    // Add event listener for mouse movement
    document.addEventListener("mousemove", this.trackMouseMove.bind(this));
  }

  disconnect() {
    // Remove the event listener when the controller is disconnected
    document.removeEventListener("mousemove", this.trackMouseMove.bind(this));

    // Unsubscribe from the channel when the controller is disconnected
    if (this.subscription) {
      this.subscription.unsubscribe();
    }
  }

  trackMouseMove(event) {
    const { clientX: x, clientY: y } = event;

    // Send the cursor position to ActionCable
    if (this.subscription) {
      this.subscription.send({ x, y }); // Now using this.subscription to send data
    }
  }

  updateCursor(user_id, x, y) {
    let cursor = document.getElementById(`cursor-${user_id}`);

    if (!cursor) {
      // Create a new cursor if one doesn't exist for this user
      cursor = document.createElement("div");
      cursor.id = `cursor-${user_id}`;
      cursor.className = "cursor";

      // Create a label to show the first 4 characters of the uuid
      const label = document.createElement("div");
      label.className = "cursor-label";
      label.textContent = user_id.substring(0, 4);

      cursor.appendChild(label);
      document.body.appendChild(cursor);
    }

    // Update the cursor position
    cursor.style.left = `${x}px`;
    cursor.style.top = `${y}px`;
  }

  removeCursor(user_id) {
    const cursor = document.getElementById(`cursor-${user_id}`);

    if (cursor) {
      cursor.remove();
    }
  }
}
