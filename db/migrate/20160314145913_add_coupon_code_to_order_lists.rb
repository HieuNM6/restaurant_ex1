class AddCouponCodeToOrderLists < ActiveRecord::Migration
  def change
    add_column :order_lists, :coupon_code, :string
  end
end
