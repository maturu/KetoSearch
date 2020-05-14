class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :tag
      t.string :name
      t.integer :gram
      t.float :calorie
      t.float :water
      t.float :protain
      t.float :lipid
      t.float :carbohydrate
      t.float :fibtg
      t.text :content
      t.string :reference
      t.string :url

      t.timestamps
    end
  end
end
