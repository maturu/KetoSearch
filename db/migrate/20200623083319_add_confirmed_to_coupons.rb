class AddConfirmedToCoupons < ActiveRecord::Migration[5.2]
  def change
    add_column :coupons, :confirmed, :boolean, null: false, default: false
  end
end
