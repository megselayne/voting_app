class CreateElections < ActiveRecord::Migration[7.0]
  def change
    create_table :elections do |t|
      t.string :name
      # Faster queries on a highly used column
      t.string :slug, index: true

      t.timestamps
    end
  end
end
