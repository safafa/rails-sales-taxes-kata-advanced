# frozen_string_literal: true

require 'test_helper'

class ReceiptsControllerTest < ActionDispatch::IntegrationTest
  test 'when not logged in, going to :index will redirect to homepage' do
    get receipts_path
    assert_redirected_to root_path
  end
end
