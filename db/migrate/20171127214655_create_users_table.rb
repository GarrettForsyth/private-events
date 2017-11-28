class CreateUsersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_digest

      t.timestamps
    end

    create_table :events do |t|
      t.belongs_to :user

      t.string :name
      t.text :description
      t.datetime :date
      t.string :location

      t.timestamps
    end
  end
end
