class StoreController < ApplicationController
  before_action :sign_in_required, only: [:new, :create]
  before_action :store_open_required, only: [:edit, :update]
  before_action :set_variables

  def show
    @store = Store.find(params[:id])
    gon.store_id = params[:id]
    gon.star_off = helpers.image_path('star-off.svg')
    gon.star_on = helpers.image_path('star-on.svg')
    gon.star_half = helpers.image_path('star-half.svg')
    @foods = @store.foods.page(params[:page]).per(12)

    respond_to do |format|
      format.html
      format.json {render json: @foods.to_json(:include => [:reviews])}
    end
  end

  def new
    @store = Store.new
  end

  def about
    @store = Store.find(params[:id])
  end

  def edit
    @store = Store.find(params[:id])
    redirect_to store_show_path(id: @store.id) if @store.user_id != current_user.id
  end

  def create
    @store = current_user.build_store(store_params)
    if @store.save
      redirect_to store_show_path(id: @store.id)
    else
      render store_new_path
    end
  end

  def update
    @store = Store.find(params[:id])
    redirect_to store_show_path(id: @store.id) if @store.user_id != current_user.id
    if @store.update(store_params)
      redirect_to store_about_path(id: @store.id)
    else
      render store_edit_path
    end
  end

  protected
    def store_params
      params.require(:store).permit(:name, :postal_code, :address, :phone_number, :description)
    end
end
