class BasketsController < ApplicationController
  def index
    @baskets = current_user.baskets.latest.paginate(page: params[:page], per_page: 5)
  end

  def show
    @basket = Basket.find(params[:id])
  end

  def new
    @basket = Basket.new
  end

  def create
    @basket = current_user.baskets.build(build_params)
    if @basket.build_entries_from_file_upload(params[:file])
      @basket.save
      redirect_to @basket
    else
      flash[:alert] = 'Please enter a valid txt file'
      redirect_to new_basket_path
    end
  end

  private

  def build_params
    { name: current_user.baskets.length + 1 }
  end
end
