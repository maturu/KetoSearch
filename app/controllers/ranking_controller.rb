class RankingController < ApplicationController
  before_action :sign_in_required, only: [:show]
  before_action :set_variables

  def show
    @foods = Food.all.page(params[:page])
  end
end
