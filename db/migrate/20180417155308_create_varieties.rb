class CreateVarieties < ActiveRecord::Migration[5.2]
  def change
    create_table :varieties do |t|
      t.string :name
      t.integer :count
      t.string :user_id
      t.string :seed_id
    end
  end
end
