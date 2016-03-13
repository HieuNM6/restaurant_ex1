class FoodItem < ActiveRecord::Base
  has_many :reviews
  def self.search(query)
    where("lower(name) like ?", "%#{query}%")
  end
end
