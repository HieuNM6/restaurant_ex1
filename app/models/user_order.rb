class UserOrder < ActiveRecord::Base
  has_many :order_lists
  attr_accessor :coupon_code

end
