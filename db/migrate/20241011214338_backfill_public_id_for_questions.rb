class BackfillPublicIdForQuestions < ActiveRecord::Migration[7.2]
  def up
    Question.where(public_id: nil).find_each do |question|
      question.update_columns(public_id: Nanoid.generate(size: 10))
    end
  end

  def down
    # No rollback needed as we're just setting a field
  end
end
