# frozen_string_literal: true

require 'test_helper'
require 'net/http'

class StaticPagesHelperTest < ActionView::TestCase
  test '#random_cat_image_url should return a url of an jpg or png image' do
    result = random_cat_image_url

    assert_match(/\A(http|www)/, result, 'Invalid URL')
    assert_match(/\.(jpg|png)\z/, result, 'Should only return either a jpg or png')
  end

  test '#random_cat_image_url should return nil if API throws error' do
    Net::HTTP.stub(:get_response, Net::HTTPError, ['www.endpoint.com']) do
      assert_nil random_cat_image_url
    end
  end

  test '#random_cat_image_url should return nil if API returns not a JSON' do
    Net::HTTP.stub(:get_response, '<a>Bad Content</a>', ['www.endpoint.com']) do
      assert_nil random_cat_image_url
    end
  end

  test '#random_cat_image_url should return nil if API returns JSON without URL' do
    JSON.stub(:parse, { name: 'cat image' }) do
      assert_nil random_cat_image_url
    end
  end
end
