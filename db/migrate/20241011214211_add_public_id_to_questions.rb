class AddPublicIdToQuestions < ActiveRecord::Migration[7.2]
  def change
    add_column :questions, :public_id, :string
    add_index :questions, :public_id, unique: true
  end
end
