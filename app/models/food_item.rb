class FoodItem < ActiveRecord::Base
  def self.search(query)
    where("lower(name) like ?", "%#{query}%")
  end
end
