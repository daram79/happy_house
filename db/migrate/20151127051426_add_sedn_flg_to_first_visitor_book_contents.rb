class AddSednFlgToFirstVisitorBookContents < ActiveRecord::Migration
  def change
    add_column :first_visitor_book_contents, :send_flg, :boolean, default: false
  end
end
