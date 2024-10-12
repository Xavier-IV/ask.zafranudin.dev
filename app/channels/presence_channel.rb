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
      user_id: connection.session_id,
      x: data["x"],
      y: data["y"]
    }
  end

  private

  def connected_users_count
    unique_users = Set.new  # Using a Set to automatically handle uniqueness

    ActionCable.server.connections.each do |connection|
      user_id = connection.session_id  # Assuming you're using `uuid` for anonymous users
      unique_users.add(user_id)
      print("#{user_id} Connected")
    end

    unique_users.count  # Return the count of unique users


    # ActionCable.server.connections.count
  end
end
