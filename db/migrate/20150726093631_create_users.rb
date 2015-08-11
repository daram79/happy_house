class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :email, null: false, default: ""
      t.text    :registration_id
      t.boolean :alram_on, default: true
      t.integer :today_visit_count, default: 0
      t.string :last_count_day
      t.integer :total_visit_count, default: 0
      t.timestamps
    end
    add_index :users, :email,                unique: true
    add_index :users, :alram_on
    add_index :users, :today_visit_count
    add_index :users, :total_visit_count
    
  end
end
