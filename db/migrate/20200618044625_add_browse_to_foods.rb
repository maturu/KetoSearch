class AddBrowseToFoods < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :browse, :integer, null: false, default: 0
  end
end
