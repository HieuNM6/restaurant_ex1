class CreateOrderLists < ActiveRecord::Migration
  def change
    create_table :order_lists do |t|
      t.string :list
      t.references :user_order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
