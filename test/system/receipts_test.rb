# frozen_string_literal: true

require 'application_system_test_case'

class ReceiptsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in confirmed_user
  end

  def upload_receipt_and_test_output(receipt_file_path, expected_strings)
    visit new_receipt_path
    file_path = "#{Rails.root}/test/fixtures/files/#{receipt_file_path}"

    attach_file(:receipt_uploaded_receipt, file_path)
    click_button 'Submit'

    expected_strings.each do |string|
      assert_text string
    end
  end

  test 'after uploading a receipt it shows you the receipt show page correctly with acceptance data 1' do
    receipt_file_path = 'receipt_imports/valid/receipt_1.txt'
    expected_strings = ['1 book: 12.49', '1 music CD: 16.49', '1 chocolate bar: 0.85',
                        'Sales Taxes: 1.50', 'Total: 29.83']

    upload_receipt_and_test_output(receipt_file_path, expected_strings)
  end

  test 'after uploading a receipt it shows you the receipt show page correctly with acceptance data 2' do
    receipt_file_path = 'receipt_imports/valid/receipt_2.txt'
    expected_strings = ['1 imported box of chocolates: 10.50', '1 imported bottle of perfume: 54.65',
                        'Sales Taxes: 7.65', 'Total: 65.15']

    upload_receipt_and_test_output(receipt_file_path, expected_strings)
  end

  test 'after uploading a receipt it shows you the receipt show page correctly with acceptance data 3' do
    receipt_file_path = 'receipt_imports/valid/receipt_3.txt'
    expected_strings = ['1 imported bottle of perfume: 32.19', '1 bottle of perfume: 20.89',
                        '1 packet of headache pills: 9.75', '1 imported box of chocolates: 11.85',
                        '1 imported box of chocolates: 11.85', 'Total: 74.68']

    upload_receipt_and_test_output(receipt_file_path, expected_strings)
  end
end
