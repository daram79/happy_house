class CreateLotteries < ActiveRecord::Migration
  def change
    create_table :lotteries do |t|
      t.integer :user_id
      t.string  :tel_no
      t.string  :lottery_type
      t.boolean :is_win, default: false
      t.integer :chance
      t.date    :date
      t.timestamps
    end
    add_index :lotteries, [:is_win, :date, :chance]
    add_index :lotteries, [:user_id, :tel_no, :lottery_type, :date]
  end
end
