class StaticPagesController < ApplicationController
  def home
    @image_url = CatApi.img_url
  end
end
