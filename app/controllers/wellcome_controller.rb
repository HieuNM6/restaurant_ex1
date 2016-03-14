class WellcomeController < ApplicationController
  def index
  end

  def menu
    @sections = %w(Breakfast Lunch Dinner Drinks)
    @food_items = filter_by_section(params[:section])
    unless params[:order].blank?
      (session[:order_ids] ||= []) << params[:order]
    end
    unless params[:un_order].blank?
      session[:order_ids].delete( params[:un_order])
    end
    case params[:sort]
    when "alphabetical"
      @food_items = @food_items.sort { |a,b| a.name.downcase <=> b.name.downcase } 
    when "price low to high"
      @food_items = @food_items.sort { |a,b| a.price <=> b.price}
    when "price high to low"
      @food_items = @food_items.sort { |a,b| b.price <=> a.price}
    when "view"
      @food_items = @food_items.sort { |a,b| b.view <=> a.view}
    end
    case params[:cuisine]
    when "Pork"
      @food_items = @food_items.select { |f| f.cuisine == "Pork"}
    when "Chicken"
      @food_items = @food_items.select { |f| f.cuisine == "Chicken"}
    when "Fish"
      @food_items = @food_items.select { |f| f.cuisine == "Fish"}
    when "Beef"
      @food_items = @food_items.select { |f| f.cuisine == "Beef"}
    end
    unless params[:search].nil?
      @food_items = FoodItem.search(params[:search])
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
    unless params[:order].nil?
      session[:order_ids] ||= []
      session[:order_ids] << params[:order].to_s
    end
    unless params[:un_order].nil?
      session[:order_ids].delete( params[:un_order])
      if(session[:order_ids].blank?)
        session.delete(:order_ids)
      else
        redirect_to order_path
      end
    end
    if session[:order_ids].nil?
      redirect_to menu_path
      return
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

end
