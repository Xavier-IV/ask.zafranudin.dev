module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # identified_by :uuid
    #
    # def connect
    #   self.uuid = SecureRandom.uuid
    #   logger.add_tags "ActionCable", uuid
    # end

    identified_by :session_id

    def connect
      self.session_id = request.session[:session_id] || SecureRandom.uuid
      logger.add_tags "ActionCable", session_id

      # You can also store this in a cookie if preferred
      cookies.signed[:user_id] ||= SecureRandom.uuid
      self.session_id = cookies.signed[:user_id]  # Use the cookie for user tracking
    end
  end
end
