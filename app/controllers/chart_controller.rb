class ChartController < ApplicationController
  before_action :sign_in_required, only: [:new, :edit, :create, :update]
  before_action :approve_rank_required, only: [:edit, :update]
  before_action :set_variables

  def show
    @foods = Food.search(params[:search])
    respond_to do |format|
      format.html
      format.json {render 'index', json: @foods.limit(9).pluck(:id, :name)} unless @foods.blank?
    end

    @food = Food.find(params[:id]) if params[:id].present?
    @food = @foods.first unless @foods.blank?

    if @food.present?
      @user = User.find(@food.user_id)
      na = @food.na ? @food.na/1000 : nil
      @f_info = {
        "糖質" => @food.carbohydrate,
        "タンパク質" => @food.protain,
        "脂質" => @food.lipid,
        "食物繊維" => @food.fibtg,
        "ナトリウム" => na,
        "水分" => @food.water
      }
      @relations = Food.related_search(@food, @food.name).order("carbohydrate DESC").page(params[:page]).per(6)
      @items = @relations.pluck(:id, :name, :carbohydrate)
    else
      redirect_to root_path
    end
  end

  def new
    @food = Food.new
    @tags = Food.pluck('tag').uniq
  end

  def edit
    @food = Food.find(params[:id])
    @tags = Food.pluck('tag').uniq
    if @food.protect and current_user.approve < 500
      redirect_to root_path
    end
  end

  def more
    @food = Food.find(params[:id])
  end

  def create
    @food = current_user.foods.new(food_params)
    if current_user.approve >= 500
      @food.protect = true
    end

    @tags = Food.pluck('tag').uniq
    @user = User.find(current_user.id)
    count = @user.approve + 1
    if @food.save
      @food.histories.create(
        user_id: current_user.id,
        food_id: @food.id,
        name: @food.name
      )
      @user.update(approve: count)
      redirect_to chart_show_path(id: @food.id)
    else
      render chart_new_path
    end
  end

  def update
    @food = Food.find(params[:id])
    if @food.protect and current_user.approve < 500
      redirect_to root_path
    end
    if current_user.approve >= 500
      @food.protect = true
    end

    @user = User.find(current_user.id)
    count = @user.approve + 1
    if @food.update(food_params)
      @food.histories.create(
        user_id: current_user.id,
        food_id: @food.id,
        name: @food.name
      )
      @user.update(approve: count)
      redirect_to chart_show_path(id: @food.id)
    else
      render chart_edit_path
    end
  end

  protected
    def food_params
      params.require(:food).permit(:tag, :name, :gram, :calorie, :water, :protain, :lipid, :carbohydrate, :content, :fibtg, :reference, :url, :na)
    end
end
