class AddViewToFoodItems < ActiveRecord::Migration
  def change
    add_column :food_items, :view, :integer
  end
end
