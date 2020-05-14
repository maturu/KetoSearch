class AddColumnToFoods < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :protect, :boolean, default: false, null: false
  end
end
