class ReviewController < ApplicationController
  before_action :sign_in_required, only: [:new, :edit, :create, :update]
  before_action :set_variables

  def show
    @food = Food.find(params[:fid])
    if params[:rate]
      @reviews = @food.reviews.where(rate: params[:rate])
    elsif params[:id]
      @reviews = @food.reviews.where(id: params[:id])
    else
      @reviews = @food.reviews
    end
    @user = User.find(@food.user_id)
    @rates = [0, 0, 0, 0, 0]
    unless @food.reviews.blank?
      @rates.each_with_index do |rate, index|
        rate = @food.reviews.where(rate: 5-index).count.quo(@food.reviews.count).to_f * 100
        @rates[index] = rate.to_i
      end
    end
  end

  def new
    @food = Food.find(params[:fid])
    @review = @food.reviews.find_by(user_id: current_user.id)
    redirect_to review_edit_path(id: @review.id) if @review.present?
    @review = @food.reviews.new
  end

  def edit
    @review = Review.find(params[:id])
    redirect_to review_show_path(fid: @review.food_id, id: @review.id) if @review.user_id != current_user.id
    @food = Food.find(@review.food_id)
  end

  def create
    @food = Food.find(params[:fid])
    @review = @food.reviews.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to chart_show_path(id: @food.id)
    else
      render review_new_path
    end
  end

  def update
    @review = Review.find(params[:id])
    redirect_to review_show_path(fid: @review.food_id, id: @review.id) if @review.user_id != current_user.id
    if @review.update(review_params)
      redirect_to review_show_path(fid: @review.food_id, id: @review.id)
    else
      render review_edit_path
    end
  end

  def destroy
    @review = Review.find(params[:id])
    redirect_to review_show_path(fid: @review.food_id, id: @review.id) if @review.user_id != current_user.id
    @review.destroy
    redirect_to users_show_path(username: User.find(@review.user_id).username)
  end

  protected
    def review_params
      params.require(:review).permit(:review_title, :review_details, :rate)
    end
end
