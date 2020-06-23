class AddDescriptionToStore < ActiveRecord::Migration[5.2]
  def change
    add_column :stores, :description, :text
  end
end
