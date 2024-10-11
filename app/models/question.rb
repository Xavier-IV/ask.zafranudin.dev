class Question < ApplicationRecord
  before_create :generate_public_id

  validates :content, presence: true, length: { minimum: 10, maximum: 500 }

  private

  def generate_public_id
    self.public_id = Nanoid.generate(size: 10) # Adjust the size as needed
  end
end
