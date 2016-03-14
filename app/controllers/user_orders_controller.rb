class UserOrdersController < ApplicationController
  def create
   @user = UserOrder.new(user_order_params)

   if @user.save
     @list = @user.order_lists.create(list: params[:order_list], coupon_code: coupon_params)
     flash[:success] = "OK"
     redirect_to check_path(order_list_id: @list.id)
   else
     redirect_to order_path
   end
    
  end

  private

  def user_order_params
    params.require(:user_order).permit(:name, :address, :number)
  end

  def coupon_params
    params.require(:user_order)[:coupon_code]
  end
end
