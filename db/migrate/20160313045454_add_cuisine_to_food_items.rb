class AddCuisineToFoodItems < ActiveRecord::Migration
  def change
    add_column :food_items, :cuisine, :string
  end
end
