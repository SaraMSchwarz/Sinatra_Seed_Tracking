class CreateSeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :seeds do |t|
      t.string :seed_name
      t.string :seed_category
      t.string :seed_variety
      t.string :seed_brand
      t.integer :seed_quantity
      t.string :seed_notes
      t.string :password_digest
    end
  end
end
