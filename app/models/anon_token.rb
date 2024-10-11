class AnonToken < ApplicationRecord
 validates :token, presence: true, uniqueness: true
    validates :expires_at, presence: true

  def valid_token?
    expires_at > Time.current
  end
end
