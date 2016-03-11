class WellcomeController < ApplicationController
  def index
  end

  def menu
    @sections = %w(Breakfast Lunch Dinner Drinks)
    @order = %w(Order not)
    @foods = FoodItem.where(section: params[:section])
  end

  def contact
  end
end
