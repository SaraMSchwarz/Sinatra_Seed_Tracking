class CreateSeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :seeds do |t|
      t.string :name
    end
  end
end
