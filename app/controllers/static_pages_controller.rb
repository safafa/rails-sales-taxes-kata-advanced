class StaticPagesController < ApplicationController
  def home
    @image_url = CatApi.getImg
  end
end
