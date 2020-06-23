class UsersController < ApplicationController
  before_action :sign_in_required, only: [:edit]
  before_action :set_variables

  def show
    @user = User.find_by(username: params[:username])
    @coupons = @user.coupons.where("confirmed = false")
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
      params.require(:user).permit(:introduction, :age, :job, :address, :website)
    end
end
