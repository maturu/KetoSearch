class ChartController < ApplicationController
  before_action :sign_in_required, only: [:new, :edit, :create, :update]
  before_action :approve_rank_required, only: [:edit, :update]
  before_action :set_variables

  def show
    redirect_to root_path if params[:search] == ""
    @foods = Food.search(params[:search]).page(1).per(9)

    respond_to do |format|
      format.html
      format.json {render 'index', json: @foods.pluck(:id, :name)} unless @foods.blank? or params[:search] == ""
    end

    unless @foods.blank?
      @food = params[:id].blank? ? @foods.first : Food.find(params[:id])
      @user = User.find(@food.user_id)
      @f_info = {
        "糖質" => @food.carbohydrate,
        "タンパク質" => @food.protain,
        "脂質" => @food.lipid,
        "食物繊維" => @food.fibtg,
        "食塩相当量" => @food.na / 1000,
        "水分" => @food.water
      }
      @relations = Food.related_search(@food, params[:search]).order("carbohydrate DESC").page(params[:page]).per(6)
    else
      redirect_to root_path
    end
  end

  def new
    @food = Food.new
    @tags = Food.pluck('tag').uniq
    @selects = []
    @tags.each_with_index do |t, i|
      @selects.push([t, i])
    end
  end

  def edit
    @food = Food.find(params[:id])
    @tags = Food.pluck('tag').uniq
    @selects = []
    @tags.each_with_index do |t, i|
      @selects.push([t, i])
    end
    if @food.protect and current_user.approve < 500
      redirect_to root_path
    end
  end

  def create
    @food = current_user.foods.new(food_params)
    if current_user.approve >= 500
      @food.protect = true
    end

    @tags = Food.pluck('tag').uniq
    @selects = []
    @tags.each_with_index do |t, i|
      @selects.push([t, i])
    end

    @user = User.find(current_user.id)
    count = @user.approve + 1
    if @food.save
      @food.histories.create(
        user_id: current_user.id,
        food_id: @food.id,
        name: @food.name
      )
      @user.update(approve: count)
      redirect_to chart_show_path(id: @food.id, search: @food.name)
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
      redirect_to chart_show_path(id: @food.id, search: @food.name)
    else
      render chart_edit_path
    end
  end

  protected
    def food_params
      params.require(:food).permit(:tag, :name, :gram, :calorie, :water, :protain, :lipid, :carbohydrate, :content, :fibtg, :reference, :url)
    end
end
