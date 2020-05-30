class AddEnterToFoods < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :enter_allergies, :boolean
  end
end
