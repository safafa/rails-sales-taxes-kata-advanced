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
end
