class AddGuideFlgToUsers < ActiveRecord::Migration
  def change
    add_column :users, :close_guide, :boolean, default: false
  end
end
