class CreatePlayAnswers < ActiveRecord::Migration
  def change
    create_table :play_answers do |t|
      t.text :answer
      t.timestamps
    end
  end
end
