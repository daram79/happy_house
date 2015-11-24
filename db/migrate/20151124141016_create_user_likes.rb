class CreateUserLikes < ActiveRecord::Migration
  def change
    create_table :user_likes do |t|
      t.integer :user_id
      t.integer :like_user_id
      t.timestamps
    end
    add_index :user_likes, :user_id
  end
end
