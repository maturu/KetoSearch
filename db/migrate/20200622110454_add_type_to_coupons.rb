class AddTypeToCoupons < ActiveRecord::Migration[5.2]
  def change
    add_column :coupons, :type, :string
  end
end
