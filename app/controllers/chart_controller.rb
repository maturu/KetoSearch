class ChartController < ApplicationController
  before_action :sign_in_required, only: [:new, :edit, :more, :create, :update]
  before_action :set_variables
  before_action :pc_only, only: [:more]

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
    redirect_to chart_show_path(id: @food.id) if @food.user_id != current_user.id
    @tags = Food.pluck('tag').uniq
  end

  def more
    @food = Food.find(params[:id])
    redirect_to chart_show_path(id: @food.id) if @food.user_id != current_user.id
  end

  def qrcode
    @food = Food.find(params[:id])
  end

  def create
    @food = current_user.foods.new(food_params)

    @tags = Food.pluck('tag').uniq
    @user = User.find(current_user.id)
    if @food.save
      redirect_to chart_qrcode_path(id: @food.id)
    else
      render chart_new_path
    end
  end

  def update
    @food = Food.find(params[:id])
    redirect_to chart_show_path(id: @food.id) if @food.user_id != current_user.id

    if @food.update(food_params)
      redirect_to chart_show_path(id: @food.id)
    else
      render chart_edit_path
    end
  end

  def destroy
    @food = Food.find(params[:id])
    redirect_to chart_show_path(id: @food.id) if @food.user_id != current_user.id
    @food.destroy
    redirect_to root_path
  end

  protected
    def food_params
      params.require(:food).permit(:tag, :name, :gram, :calorie, :water, :protain, :lipid, :carbohydrate, :content, :fibtg, :reference, :url, :na, :address, :egg, :milk, :wheat, :peanut, :shrimp, :crab, :buckwheat, :allergies)
    end
end
