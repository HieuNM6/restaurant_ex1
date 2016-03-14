class WellcomeController < ApplicationController
  def index
  end

  def menu
    @sections = %w(Breakfast Lunch Dinner Drinks)
    @food_items = filter_food_item_by_section(params[:section])
    push_food_item_to_cart(params[:order])
    pop_food_item_out_of_cart(params[:un_order])
    @food_items = sort_food_item_by_sort_params(params[:sort], @food_items)
    @food_items = filter_food_item_by_cuisine_params(params[:cuisine], @food_items)
    @food_items = filter_by_search_params(params[:search],@food_items)
  end

  def contact
  end


  def order
    push_food_item_to_cart(params[:order])
    pop_food_item_out_of_cart(params[:un_order])
    if(session[:order_ids].blank?)
      redirect_to menu_path
    end
    @foods = []
    session[:order_ids].each do |id|
      @foods << FoodItem.find(id)
    end
    @total_price = 0
    @user = UserOrder.new
  end

  def check_out
    if(flash[:success].nil?)
      redirect_to menu_path
    end
    @order = OrderList.find(params[:order_list_id])
    @orders = []
    orders_lists = @order.list.split(" ")
    orders_lists.each do |o|
      @orders << FoodItem.find(o.to_i)
    end 
    @user = UserOrder.find(@order.user_order_id)
    @total_price = 0
    session.delete(:order_ids)
  end

  private

  def filter_food_item_by_section(sections)
    if sections.blank?
      @foods = FoodItem.all
    else
      @foods = FoodItem.where(section: sections)
    end
  end

  def push_food_item_to_cart(order)
    unless order.blank?
      (session[:order_ids] ||= []) << order
    end
  end

  def pop_food_item_out_of_cart(un_order)
    unless un_order.blank?
      session[:order_ids].delete(un_order)
    end
  end

  def sort_food_item_by_sort_params(params, food)
    case params
    when "alphabetical"
      food = food.sort { |a,b| a.name.downcase <=> b.name.downcase } 
    when "price low to high"
      food = food.sort { |a,b| a.price <=> b.price}
    when "price high to low"
      food = food.sort { |a,b| b.price <=> a.price}
    when "view"
      food = food.sort { |a,b| b.view <=> a.view}
    end
    food
  end
  
  def filter_food_item_by_cuisine_params(params, food)
    case params
    when "Pork"
      food = food.select { |f| f.cuisine == "Pork"}
    when "Chicken"
      food = food.select { |f| f.cuisine == "Chicken"}
    when "Fish"
      food = food.select { |f| f.cuisine == "Fish"}
    when "Beef"
      food = food.select { |f| f.cuisine == "Beef"}
    end
    food
  end

  def filter_by_search_params(search,food)
    unless search.nil?
      food = food.search(search)
    end
    food
  end

end
