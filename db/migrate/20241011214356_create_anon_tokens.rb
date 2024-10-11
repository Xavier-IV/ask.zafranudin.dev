class CreateAnonTokens < ActiveRecord::Migration[7.2]
  def change
    create_table :anon_tokens do |t|
      t.string :token
      t.datetime :expires_at

      t.timestamps
    end

    add_index :anon_tokens, :token, unique: true
  end
end
