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
    if session[:order_ids].nil?
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

end
