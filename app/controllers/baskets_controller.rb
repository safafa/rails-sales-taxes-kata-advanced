class BasketsController < ApplicationController
  def index
    @baskets = current_user.baskets.all
  end

  def show
    @basket = Basket.find(params[:id])
  end

  def new
    @basket = Basket.new
  end

  def create
    @basket = current_user.baskets.build(sales_taxes: 0, total: 0)
    @basket.build_entries_from_file_upload(params[:file])
    @basket.save
    redirect_to basket_path(@basket.id)
  end
end
