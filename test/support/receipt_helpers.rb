# frozen_string_literal: true

require 'active_support/test_case'

module ActiveSupport
  class TestCase
    FIXTURES_FILES_PATH = Rails.root.join 'test/fixtures/files/'

    def valid_receipt_one
      filename = "#{FIXTURES_FILES_PATH}/receipt_imports/valid/receipt_1.txt"
      @valid_receipt_one ||= create_test_uploaded_file(filename)
    end

    def valid_receipt_two
      filename = "#{FIXTURES_FILES_PATH}/receipt_imports/valid/receipt_2.txt"
      @valid_receipt_two ||= create_test_uploaded_file(filename)
    end

    def valid_receipt_three
      filename = "#{FIXTURES_FILES_PATH}/receipt_imports/valid/receipt_3.txt"
      @valid_receipt_three ||= create_test_uploaded_file(filename)
    end

    def invalid_receipt_format
      filename = "#{FIXTURES_FILES_PATH}/receipt_imports/invalid/bad_format.txt"
      @invalid_receipt_format ||= create_test_uploaded_file(filename)
    end

    def invalid_receipt_product
      filename = "#{FIXTURES_FILES_PATH}/receipt_imports/invalid/bad_product.txt"
      @invalid_receipt_product ||= create_test_uploaded_file(filename)
    end
  end
end
