class AddPushMsgToAlrams < ActiveRecord::Migration
  def change
    add_column :alrams, :push_msg, :string
  end
end
