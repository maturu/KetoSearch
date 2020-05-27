class AddAddressToFoods < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :address, :string
  end
end
