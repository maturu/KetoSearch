class DeleteCouponTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications, :coupon_id, :references
    drop_table :coupons
  end
end
