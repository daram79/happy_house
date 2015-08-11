class CreateUserVisitCounts < ActiveRecord::Migration
  def change
    create_table :user_visit_counts do |t|
      t.integer :user_id
      t.integer :visit_user_id
      t.timestamps
    end
    add_index :user_visit_counts, [:user_id, :visit_user_id]
  end
end
