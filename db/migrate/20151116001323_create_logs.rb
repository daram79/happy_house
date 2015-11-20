class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :user_id, default: nil
      t.text :uniq_key, default: nil
      t.string  :first_log_type
      t.string  :second_log_type
      t.string  :device
      t.timestamps
    end
    add_index :logs, :user_id
    add_index :logs, [:first_log_type, :second_log_type]
    add_index :logs, :device
  end
end
