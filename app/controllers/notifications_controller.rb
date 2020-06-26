class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications
    @items = []
    @notifications.each do |n|
      coupon_confirmed = n.coupon_id.blank? ? false : Coupon.find(n.coupon_id).confirmed
      @items.push({
        'food_id' => n.food_id,
        'review_id' => n.review_id,
        'coupon_id' => n.coupon_id,
        'coupon_confirmed' => coupon_confirmed,
        'visiter_name' => User.find(n.visiter_id).username,
        'food_name' => Food.find(n.food_id).name,
        'action' => n.action,
        'created_at' => n.created_at.in_time_zone('Asia/Tokyo').to_date.strftime("%Y年%m月%d日")
      })
    end

    respond_to do |format|
      format.html {redirect_to root_path}
      format.json {render json: @items}
    end
  end
end
