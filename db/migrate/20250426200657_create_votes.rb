class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :candidate, null: false, foreign_key: true
      t.references :election, null: false, foreign_key: true

      t.timestamps
    end
      # Ensures uniqueness across user and election
      add_index :votes, [:user_id, :election_id], unique: true
  end
end
