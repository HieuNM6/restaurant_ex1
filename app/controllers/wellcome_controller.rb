class WellcomeController < ApplicationController
  def index
  end

  def menu
    @sections = %w(Breakfast Lunch Dinner Drinks)
    @foods = filter_by_section(params[:section])
    unless params[:order].blank?
      (session[:order_ids] ||= []) << params[:order]
    end
  end

  def contact
  end
  def filter_by_section(sections)
    if sections.blank?
      @foods = FoodItem.all
    else
      @foods = FoodItem.where(section: sections)
    end
  end

  def order

  end

  def add_to_order(food)
    session[:order_id] = food.id
    redirect_to '/menu'
  end
end
