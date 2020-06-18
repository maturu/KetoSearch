class AddPostalCodeToStores < ActiveRecord::Migration[5.2]
  def change
    add_column :stores, :postal_code, :string
  end
end
