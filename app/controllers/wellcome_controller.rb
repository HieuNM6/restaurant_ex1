class WellcomeController < ApplicationController
  def index
  end

  def menu
    @sections = %w(Breakfast Lunch Dinner Drinks)
    @foods = filter_by_section(params[:section])
    unless params[:order].blank?
      (session[:order_ids] ||= []) << params[:order]
    end
    unless params[:un_order].blank?
      session[:order_ids].delete( params[:un_order])
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
    @foods = []
    session[:order_ids].each do |id|
      @foods << FoodItem.find(id)
    end
    @total_price = 0
    @user = UserOrder.new
  end

  def check_out

  end

end
