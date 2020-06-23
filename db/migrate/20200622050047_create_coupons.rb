class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.references :user, foreign_key: true
      t.references :review, foreign_key: true
      t.references :store, foreign_key: true
      t.string :signature
      t.date :expiration_date
      t.integer :price

      t.timestamps
    end
  end
end
