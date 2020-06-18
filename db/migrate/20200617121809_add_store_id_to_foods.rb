class AddStoreIdToFoods < ActiveRecord::Migration[5.2]
  def change
    add_reference :foods, :store, foreign_key: true
  end
end
