class AddReportToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :report, :integer, null: false, default: 0
  end
end
