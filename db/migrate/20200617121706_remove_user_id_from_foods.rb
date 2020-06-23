class RemoveUserIdFromFoods < ActiveRecord::Migration[5.2]
  def change
    remove_reference :foods, :user, foreign_key: true
  end
end
