# frozen_string_literal: true

require 'test_helper'

class StaticPagesTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'homepage should have a random cat image' do
    get root_path

    valid_image_from_catapi_regexp = /catapi.+\.(jpg|png)/
    assert_select 'img', src: valid_image_from_catapi_regexp, count: 1
  end
end
