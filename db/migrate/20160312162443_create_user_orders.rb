class CreateUserOrders < ActiveRecord::Migration
  def change
    create_table :user_orders do |t|
      t.string :name
      t.string :adress
      t.string :number

      t.timestamps null: false
    end
  end
end
