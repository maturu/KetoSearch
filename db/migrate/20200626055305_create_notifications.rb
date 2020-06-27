class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visiter_id
      t.integer :visited_id
      t.references :review, foreign_key: true
      t.references :coupon, foreign_key: true
      t.string :action
      t.boolean :checked, null: false, default: false

      t.timestamps
    end
  end
end
