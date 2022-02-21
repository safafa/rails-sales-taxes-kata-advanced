class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @image_url = CatApi.img_url
  end
end
