class AddPriceToFoods < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :price, :integer
  end
end
