class RemoveApproveFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :approve, :integer
  end
end
