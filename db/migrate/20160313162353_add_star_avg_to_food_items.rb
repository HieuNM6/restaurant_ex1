class AddStarAvgToFoodItems < ActiveRecord::Migration
  def change
    add_column :food_items, :star_avg, :decimal
  end
end
