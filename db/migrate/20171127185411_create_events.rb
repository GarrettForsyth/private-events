class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :date
      t.string :location
      t.integer :creator_id

      t.timestamps
    end

    add_index :events, :creator_id
    add_foreign_key :events, :creators

  end
end
