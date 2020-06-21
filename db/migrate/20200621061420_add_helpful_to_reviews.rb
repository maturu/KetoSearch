class AddHelpfulToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :helpful, :integer, null: false, default: 0
  end
end
