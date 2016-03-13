class ReviewsController < ApplicationController
  def create
  	   @food = FoodItem.find(params[:food_item_id])
	   @review = @food.reviews.create(review_params)

	   if @review.save
	     redirect_to @food
	   else
	   	 redirect_to @food
	   end
  end

  private

  def review_params
    params.require(:review).permit(:star, :text)
  end
end
