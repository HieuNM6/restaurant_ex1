class WellcomeController < ApplicationController
  def index
  end

  def menu
    @sections = %w(Breakfast Lunch Dinner Drinks)
    @foods = FoodItem.where(section: params[:section])
  end

  def contact
  end
end
