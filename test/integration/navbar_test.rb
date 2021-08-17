# frozen_string_literal: true

require 'test_helper'

class NavbarTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'navbar should have login button when not logged in' do
    get root_path

    assert_select 'nav' do
      assert_select 'a', text: 'Login', href: login_path
    end
  end

  test 'navbar should have logout button when logged in' do
    sign_in confirmed_user
    get root_path

    assert_select 'nav' do
      assert_select 'a', text: 'Logout', href: logout_path
    end
  end

  test 'navbar should have Upload Receipt link when logged in' do
    sign_in confirmed_user
    get root_path

    assert_select 'nav' do
      assert_select 'a', text: 'Upload Receipt', href: new_receipt_path
    end
  end

  test 'navbar should not have Upload Receipt link when logged in' do
    get root_path

    assert_select 'nav' do
      assert_select 'a', text: 'My Receipts', href: new_receipt_path, count: 0
    end
  end

  test 'navbar should have My Receipts link when logged in' do
    sign_in confirmed_user
    get root_path

    assert_select 'nav' do
      assert_select 'a', text: 'My Receipts', href: receipts_path
    end
  end

  test 'navbar should not have My Receipts link when logged in' do
    get root_path

    assert_select 'nav' do
      assert_select 'a', text: 'My Receipts', href: receipts_path, count: 0
    end
  end
end
