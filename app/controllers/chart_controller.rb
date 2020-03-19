class ChartController < ApplicationController
  def show
    redirect_to root_path if params[:search] == ""
    @foods = Food.search(params[:search]).page(1).per(9)

    respond_to do |format|
      format.html
      format.json {render 'index', json: @foods} unless @foods.blank? or params[:search] == ""
    end

    unless @foods.blank?
      @food = params[:id].blank? ? @foods.first : Food.find(params[:id])
      @price = @food.price_id.blank? ? nil : Price.where("price_id = #{@food.price_id}").first
      @p_info = {
        "2019-02" => @price.twenty_nineteen_feb,
        "2019-03" => @price.twenty_nineteen_mar,
        "2019-04" => @price.twenty_nineteen_apr,
        "2019-05" => @price.twenty_nineteen_may,
        "2019-06" => @price.twenty_nineteen_jun,
        "2019-07" => @price.twenty_nineteen_jul,
        "2019-08" => @price.twenty_nineteen_aug,
        "2019-09" => @price.twenty_nineteen_sep,
        "2019-10" => @price.twenty_nineteen_oct,
        "2019-11" => @price.twenty_nineteen_nov,
        "2019-12" => @price.twenty_nineteen_dec,
        "2020-01" => @price.twenty_twenty_jan,
        "2020-02" => @price.twenty_twenty_feb
      } unless @price.blank?
      @f_info = {
        "糖質" => @food.carbohydrate,
        "タンパク質" => @food.protain,
        "脂質" => @food.lipid
      }
      @relations = Food.related_search(@food, params[:search]).order("carbohydrate DESC").page(params[:page]).per(6)
    else
      redirect_to root_path
    end
  end
end
