class UsersController < ApplicationController
  before_action :sign_in_required, only: [:edit]
  before_action :set_variables

  def show
    @user = User.find_by(username: params[:username])
    @foods = @user.store.foods.all.order(created_at: "DESC")
    @dates = @foods.map{|f| f.created_at.to_date}.uniq

    data = @foods.map{|f|
      f.created_at.beginning_of_day.to_i
    }.inject(Hash.new(0)){|h, tm|
      h[tm] += 1; h
    }.to_json
    gon.data = data
  end

  def edit
    @user = User.find(params[:id])
    redirect_to root_path if @user.id != current_user.id
  end

  def update
    @user = User.find(params[:id])
    redirect_to root_path if @user.id != current_user.id
    if @user.update(user_params)
      redirect_to users_show_path(username: @user.username)
    end
  end

  private
    def user_params
      params.require(:user).permit(:introduction, :store, :address, :website)
    end
end
