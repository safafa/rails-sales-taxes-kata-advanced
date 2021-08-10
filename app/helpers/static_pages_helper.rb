# frozen_string_literal: true

require 'net/http'

module StaticPagesHelper
  def random_cat_image_url
    return 'https://cdn2.thecatapi.com/images/2f4.jpg' if Rails.env.development?

    uri = URI(random_cat_api_endpoint)
    response = Net::HTTP.get_response(uri)
    image_hashes = JSON.parse(response.body)
    image_hashes.first['url']
  rescue
    nil
  end

  private

  def random_cat_api_endpoint
    'https://api.thecatapi.com/v1/images/search?mime_types=jpg,png'
  end
end
