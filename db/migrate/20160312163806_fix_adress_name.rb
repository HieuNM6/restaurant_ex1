class FixAdressName < ActiveRecord::Migration
  def change
    rename_column :user_orders, :adress, :address
  end
end
