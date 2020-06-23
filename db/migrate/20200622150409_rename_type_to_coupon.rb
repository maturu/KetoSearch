class RenameTypeToCoupon < ActiveRecord::Migration[5.2]
  def change
    rename_column :coupons, :type, :coupon_color
  end
end
