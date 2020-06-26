class CouponController < ApplicationController
  before_action :sign_in_required, only: [:show, :new, :create, :use, :confirm]
  before_action :store_open_required, only: [:new, :create]
  before_action :set_variables

  def show
    @coupon = Coupon.find(params[:id])
    @user = User.find(@coupon.user_id)
    gon.coupon_id = params[:id]
    if current_user.id != @coupon.user_id or @coupon.confirmed
      redirect_to users_show_path(username: @user.username)
    end
    @store = Store.find(@coupon.store_id)
  end

  def new
    @review = Review.find(params[:id])
    redirect_to review_show_path(fid: @review.food_id, id: @review.id) if @review.coupon
    @user = User.find(@review.user_id)
    @coupon = Coupon.new
  end

  def create
    @review = Review.find(params[:id])
    redirect_to review_show_path(fid: @review.food_id, id: @review.id) if @review.coupon
    @user = User.find(@review.user_id)
    @coupon = @review.build_coupon(coupon_params)
    @coupon.user_id = @review.user_id
    @coupon.store_id = current_user.store.id
    if @coupon.save
      current_user.active_notifications.create!(
        food_id: @review.food_id,
        coupon_id: @coupon.id,
        visited_id: @review.user_id,
        action: "coupon"
      )
      redirect_to review_show_path(fid: @review.food_id, id: @review.id)
    else
      render coupon_new_path
    end
  end

  def use
    @coupon = Coupon.find(params[:id])
    @user = User.find(@coupon.user_id)
    redirect_to users_show_path(username: @user.username) if current_user.id != @coupon.user_id
    @coupon.update(used: true)
  end

  def confirm
    @coupon = Coupon.find(params[:id])
    @user = User.find(@coupon.user_id)
    redirect_to users_show_path(username: @user.username) if current_user.id != @coupon.user_id
    @coupon.update(confirmed: true)
  end

  protected
    def coupon_params
      params.require(:coupon).permit(:signature, :price, :expiration_date, :coupon_color)
    end
end
