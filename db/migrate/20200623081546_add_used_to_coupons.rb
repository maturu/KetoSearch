class AddUsedToCoupons < ActiveRecord::Migration[5.2]
  def change
    add_column :coupons, :used, :boolean, null: false, default: false
  end
end
