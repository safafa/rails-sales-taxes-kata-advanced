# frozen_string_literal: true

require 'test_helper'

class ReceiptsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'when not logged in, going to :index will redirect to homepage' do
    get receipts_path
    assert_redirected_to root_path
  end

  test 'when not logged in, going to :show will redirect to homepage' do
    get receipt_path(1)
    assert_redirected_to root_path
  end

  test 'a logged in user cannot see receipts from another user' do
    another_user = create_user
    another_users_receipt = another_user.receipts.create
    sign_in confirmed_user

    get receipt_path(another_users_receipt)

    assert_redirected_to root_path
  end
end
