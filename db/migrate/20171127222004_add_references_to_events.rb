class AddReferencesToEvents < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :creator_id
    add_reference :events, :creator, foreign_key: true
  end
end
