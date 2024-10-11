class PresenceChannel < ApplicationCable::Channel
  def subscribed
    # Each user is subscribed to this channel
    stream_from "presence_channel"

    # Broadcast user connected and the total count
    ActionCable.server.broadcast "presence_channel", {
      type: "user_connected",
      count: connected_users_count
    }
  end

  def unsubscribed
    # Broadcast user disconnected and the total count
    ActionCable.server.broadcast "presence_channel", {
      type: "user_disconnected",
      count: connected_users_count - 1
    }
  end

  def receive(data)
    # Broadcast cursor position to everyone
    ActionCable.server.broadcast "presence_channel", {
      type: "cursor_position",
      user_id: connection.uuid,
      x: data["x"],
      y: data["y"]
    }
  end

  private

  def connected_users_count
    ActionCable.server.connections.count
  end
end
