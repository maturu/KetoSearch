class RemoveProtectFromFoods < ActiveRecord::Migration[5.2]
  def change
    remove_column :foods, :protect, :boolean
  end
end
