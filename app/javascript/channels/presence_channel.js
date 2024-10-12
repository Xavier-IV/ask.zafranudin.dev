import { createConsumer } from "@rails/actioncable";

const consumer = createConsumer();

consumer.subscriptions.create("PresenceChannel", {
  connected() {},

  disconnected() {},

  received(data) {
    if (data.type === "user_connected" || data.type === "user_disconnected") {
      // document.getElementById("active-users-count").textContent =
      // `Active Users: ${data.count}`;
    } else if (data.type === "cursor_position") {
      const cursor =
        document.getElementById(`cursor-${data.user_id}`) ||
        createCursor(data.user_id);
      moveCursor(cursor, data.x, data.y);
    }
  },
});

function createCursor(userId) {
  const cursor = document.createElement("div");
  cursor.id = `cursor-${userId}`;
  cursor.className = "cursor";
  document.body.appendChild(cursor);
  return cursor;
}

function moveCursor(cursor, x, y) {
  cursor.style.left = `${x}px`;
  cursor.style.top = `${y}px`;
}
