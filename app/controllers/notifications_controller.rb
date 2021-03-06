class NotificationsController < ApplicationController
  def index
    to  = Time.current.at_end_of_day
    from    = (to - 6.day).at_beginning_of_day
    @notifications = current_user.passive_notifications.where(created_at: from...to)
    @items = []
    @notifications.each do |n|
      @items.push({
        'id' => n.id,
        'food_id' => n.food_id,
        'review_id' => n.review_id,
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

  def attention
    @notifications = current_user.passive_notifications
    respond_to do |format|
      format.html {redirect_to root_path}
      format.json {render json: @notifications.where(checked: false).where("id > ?", params[:id])}
    end
  end

  def update
    @notifications = current_user.passive_notifications
    @notifications.where(checked: false).update_all(checked: true)
  end
end
