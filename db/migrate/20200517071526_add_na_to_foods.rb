class AddNaToFoods < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :na, :float
  end
end
