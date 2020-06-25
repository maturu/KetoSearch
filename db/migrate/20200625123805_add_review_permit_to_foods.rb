class AddReviewPermitToFoods < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :review_permit, :boolean, null: false, default: true
  end
end
