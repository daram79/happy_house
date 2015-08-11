class CreateUserCovers < ActiveRecord::Migration
  def change
    create_table :user_covers do |t|
      t.integer :user_id
      t.string  :name
      t.string  :image
      t.timestamps
    end
    add_index :user_covers, :user_id
  end
end
