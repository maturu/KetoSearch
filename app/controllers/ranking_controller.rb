class RankingController < ApplicationController
  before_action :sign_in_required, only: [:show]
  before_action :set_variables

  def show
    @user = User.find_by(username: params[:username])
    params[:user_id] = @user.nil? ? nil : @user.id
    @sorts = {
      "糖質昇順" => "carbohydrate ASC",
      "糖質降順" => "carbohydrate DESC",
      "脂質昇順" => "lipid ASC",
      "脂質降順" => "lipid DESC",
      "タンパク質昇順" => "protain ASC",
      "タンパク質降順" => "protain DESC"
    }
    @foods = Food.refine_search(params).order(@sorts[params[:sort]]).page(params[:page])
    @tags = Food.pluck(:tag).uniq
    @items = @foods.pluck(:id, :name)
  end
end
