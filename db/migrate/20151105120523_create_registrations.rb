class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :user_id, :null => false
      t.text    :registration_id, :null => false
      t.timestamps
    end
    add_index :registrations, :user_id
  end
end
