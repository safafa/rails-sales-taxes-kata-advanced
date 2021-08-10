# frozen_string_literal: true

require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get homepage' do
    get root_path
    assert_response :success
  end
end
