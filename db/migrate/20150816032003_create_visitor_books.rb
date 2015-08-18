class CreateVisitorBooks < ActiveRecord::Migration
  def change
    create_table :visitor_books do |t|
      t.integer :user_id
      t.integer :send_user_id
      t.text  :content
      t.text  :comment
      t.timestamps
    end
    add_index :visitor_books, :user_id
  end
end
