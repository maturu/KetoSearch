class RankingController < ApplicationController
  def show
    @foods = Food.where("tag = ?", params[:tag])
    if params[:comp] == "protain"
      @foods = @foods.order("#{params[:comp]} DESC").page(params[:page])
    else
      @foods = @foods.order(params[:comp]).page(params[:page])
    end
  end
end
