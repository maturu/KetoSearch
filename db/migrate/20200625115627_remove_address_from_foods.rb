class RemoveAddressFromFoods < ActiveRecord::Migration[5.2]
  def change
    remove_column :foods, :address, :string
  end
end
