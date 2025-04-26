class CreateCandidates < ActiveRecord::Migration[7.0]
  def change
    create_table :candidates do |t|
      t.string :name
      # index for efficiency in joining to votes table for results
      t.references :election, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
