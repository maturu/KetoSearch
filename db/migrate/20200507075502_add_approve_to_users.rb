class AddApproveToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :approve, :integer, default: 0
  end
end
