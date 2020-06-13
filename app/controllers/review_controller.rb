class ReviewController < ApplicationController
  before_action :sign_in_required, only: [:new, :create]
  before_action :set_variables

  def show
  end

  def new
    @food = Food.find(params[:id])
    @review = @food.reviews.new
  end

  def create
    @food = Food.find(params[:id])
    @review = @food.reviews.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to chart_show_path(id: @food.id)
    else
      render review_new_path
    end
  end

  protected
    def review_params
      params.require(:review).permit(:review_title, :review_details, :rate)
    end
end
