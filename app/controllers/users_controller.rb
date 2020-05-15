class UsersController < ApplicationController
  before_action :sign_in_required, only: [:show]
  before_action :set_variables

  def show
    @user = User.find_by(username: params[:username])
    @histories = @user.histories.all.order(created_at: "DESC")
    @dates = @histories.map{|h| h.created_at.to_date}.uniq

    data = @histories.map{|h|
      h.created_at.beginning_of_day.to_i
    }.inject(Hash.new(0)){|h, tm|
      h[tm] += 1; h
    }.to_json
    gon.data = data
  end
end
