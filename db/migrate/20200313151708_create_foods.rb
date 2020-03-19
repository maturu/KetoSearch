class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.integer :category
      t.integer :price_id
      t.string :tag
      t.string :name
      t.float :calorie
      t.float :water
      t.float :protain
      t.float :lipid
      t.float :carbohydrate

      t.timestamps
    end
  end
end
