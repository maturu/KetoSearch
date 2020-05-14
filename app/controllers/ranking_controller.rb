class RankingController < ApplicationController
  before_action :sign_in_required, only: [:show]

  def show
    @foods = Food.all.page(params[:page])
  end
end
