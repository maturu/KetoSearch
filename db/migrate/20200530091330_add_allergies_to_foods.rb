class AddAllergiesToFoods < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :egg, :boolean
    add_column :foods, :milk, :boolean
    add_column :foods, :wheat, :boolean
    add_column :foods, :shrimp, :boolean
    add_column :foods, :crab, :boolean
    add_column :foods, :peanut, :boolean
    add_column :foods, :buckwheat, :boolean
    add_column :foods, :allergies, :string
  end
end
