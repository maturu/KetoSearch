class RankingController < ApplicationController
  before_action :sign_in_required, only: [:show]
  before_action :set_variables

  def show
    @foods = params[:tag].nil? ? Food.all.page(params[:page]) : Food.where("tag LIKE ?", "%#{params[:tag]}%").page(params[:page])
    @items = @foods.pluck(:id, :name)
  end
end
