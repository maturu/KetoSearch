class SubscribeController < ApplicationController
  before_action :sign_in_required, only: [:create, :destroy]

  def create
    @subscribe = current_user.subscribes.create(store_id: params[:id])
  end

  def destroy
    @subscribe = current_user.subscribes.find_by(store_id: params[:id])
    @subscribe.destroy
  end
end
