class CreateFrames < ActiveRecord::Migration
  def change
    create_table :frames do |t|
      t.integer :game_id
      t.integer :player_id
      t.integer :shot_1
      t.integer :shot_2
      t.integer :shot_3
      t.integer :number

      t.timestamps null: false
    end
    add_index :frames, :game_id
    add_index :frames, :player_id
  end
end
