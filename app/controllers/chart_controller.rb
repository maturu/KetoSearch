class ChartController < ApplicationController
  before_action :sign_in_required, only: [:new, :edit, :more, :create, :update]
  before_action :store_open_required, only: [:new, :edit, :more, :create, :update]
  before_action :set_variables
  before_action :pc_only, only: [:more]

  def show
    @foods = Food.search(params[:search])
    respond_to do |format|
      format.html {
        @food = Food.find(params[:id]) if params[:id].present?
        @food = @foods.first unless @foods.blank?

        if @food.present?
          @store = Store.find(@food.store_id)
          @food.update(browse: @food.browse+1)
          na = @food.na ? @food.na/1000 : nil
          @f_info = {
            "糖質" => @food.carbohydrate,
            "タンパク質" => @food.protain,
            "脂質" => @food.lipid,
            "食物繊維" => @food.fibtg,
            "ナトリウム" => na,
            "水分" => @food.water
          }
          @rates = [0, 0, 0, 0, 0]
          unless @food.reviews.blank?
            @rates.each_with_index do |rate, index|
              rate = @food.reviews.where(rate: 5-index).count.quo(@food.reviews.count).to_f * 100
              @rates[index] = rate.to_i
            end
          end
          @relations = Food.related_search(@food, @food.name).order("carbohydrate DESC").page(params[:page]).per(6)
          @items = @relations.pluck(:id, :name, :carbohydrate)
        else
          redirect_to root_path
        end
      }
      format.json {
        render json: @foods.limit(5).pluck(:id, :name)
      } unless @foods.blank?
    end
  end

  def new
    @food = Food.new
  end

  def edit
    @food = Food.find(params[:id])
    redirect_to chart_show_path(id: @food.id) if @food.store_id != current_user.store.id
  end

  def more
    @food = Food.find(params[:id])
    redirect_to chart_show_path(id: @food.id) if @food.store_id != current_user.store.id
  end

  def qrcode
    @food = Food.find(params[:id])
  end

  def create
    @food = current_user.store.foods.new(food_params)
    if @food.save
      redirect_to chart_qrcode_path(id: @food.id)
    else
      render chart_new_path
    end
  end

  def update
    @food = Food.find(params[:id])
    redirect_to chart_show_path(id: @food.id) if @food.store_id != current_user.store.id
    if @food.update(food_params)
      redirect_to chart_show_path(id: @food.id)
    else
      render chart_edit_path
    end
  end

  def destroy
    @food = Food.find(params[:id])
    redirect_to chart_show_path(id: @food.id) if @food.store_id != current_user.store.id
    @food.destroy
    redirect_to root_path
  end

  def incremental
    @user = User.find_by(admin: 1)
    @foods = @user.store.foods.search(params[:search])
    respond_to do |format|
      format.json {
        render json: @foods.limit(5).pluck(:id, :name)
      } unless @foods.blank?
    end
  end

  def calc
    names = params[:names].split(",").to_a
    grams = params[:grams].split(",").to_a
    @grams = []
    names.zip(grams) do |n, g|
      @grams.push(g) if n != "" and g != ""
    end
    @foods = Food.where(name: names)
    @result = {gram: 0, calorie: 0, protain: 0, lipid: 0, carbohydrate: 0, water: 0, fibtg: 0, na: 0}
    @result.each do |key, val|
      @result[key] = @foods.pluck(key).each.with_index.inject(0){|sum, (i, j)|
        i = 0 if i.nil?
        sum + i*@grams[j].to_i/@foods.pluck(:gram)[j]
      }.floor(1)
    end
    @result["reference"] = @foods.first.reference
    @result["url"] = @foods.first.url

    respond_to do |format|
      format.html {redirect_to root_path}
      format.json {render 'index', json: @result}
    end
  end

  protected
    def food_params
      params.require(:food).permit(
        :tag, :name, :gram, :calorie, :water, :protain, :lipid, :carbohydrate, :content, :fibtg,\
        :reference, :url, :na, :egg, :milk, :wheat, :peanut, :shrimp, :crab, :buckwheat, :allergies,\
        :enter_allergies, :price, :review_permit
      )
    end
end
