require 'rest-client'

class CatApi
  def self.img_url
    response = RestClient::Request.execute(method: :get,
                                           url: 'https://api.thecatapi.com/v1/images/search',
                                           api_key: ENV['API_KEY'])
    JSON.parse(response.body)[0]['url']
  end
end
