# frozen_string_literal: true

require 'test_helper'

class ReceiptsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'when not logged in, getting :new will redirect to homepage' do
    get new_receipt_path
    assert_redirected_to root_path
  end

  test 'when not logged in, posting to :create will redirect to homepage' do
    post receipts_path
    assert_redirected_to root_path
  end

  test 'POSTing a valid uploaded receipt' do
    assert_difference 'Receipt.count', 1 do
      sign_in confirmed_user
      post receipts_path, params: { receipt: { uploaded_receipt: valid_receipt_one } }
    end
  end

  test 'POSTing an invalid uploaded receipt' do
    assert_no_difference ['Receipt.count', 'ReceiptItem.count'] do
      sign_in confirmed_user
      post receipts_path, params: { receipt: { uploaded_receipt: invalid_receipt_format } }
    end
  end

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
