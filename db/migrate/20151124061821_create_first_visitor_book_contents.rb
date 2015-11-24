class CreateFirstVisitorBookContents < ActiveRecord::Migration
  def change
    create_table :first_visitor_book_contents do |t|
      t.text  :content
      t.timestamps
    end
  end
end
