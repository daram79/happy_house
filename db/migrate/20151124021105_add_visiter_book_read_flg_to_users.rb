class AddVisiterBookReadFlgToUsers < ActiveRecord::Migration
  def change
    add_column :users, :visiter_book_read_flg, :boolean, default: true
  end
end
