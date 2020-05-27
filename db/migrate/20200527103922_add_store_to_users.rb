class AddStoreToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :store, :string
  end
end
