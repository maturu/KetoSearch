class RemoveStoreFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :store, :string
  end
end
