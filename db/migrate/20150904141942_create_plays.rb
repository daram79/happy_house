class CreatePlays < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      t.integer :play_answer_id
      t.string :uniq_key
      t.string :owner_name
      t.string :animal_name
      t.text :answer
      t.timestamps
    end
    add_index :plays, [:uniq_key, :owner_name, :animal_name]
  end
end
