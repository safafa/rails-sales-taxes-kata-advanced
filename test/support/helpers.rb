# frozen_string_literal: true

require 'active_support/test_case'

module ActiveSupport
  class TestCase
    FIXTURES_FILES_PATH = Rails.root.join 'test/fixtures/files/'

    def setup_mailer
      ActionMailer::Base.deliveries = []
    end

    def create_test_uploaded_file(path)
      Rack::Test::UploadedFile.new path, 'text/plain'
    end

    def blank_file
      @blank_file ||= create_test_uploaded_file("#{FIXTURES_FILES_PATH}/blank_file.txt")
    end

    def generate_unique_email
      @@email_count ||= 0
      @@email_count += 1
      "test#{@@email_count}@example.com"
    end

    def valid_attributes(attributes = {})
      { email: generate_unique_email,
        password: '12345678',
        password_confirmation: '12345678' }.update(attributes)
    end

    def create_user(attributes = {})
      User.create!(valid_attributes(attributes))
    end

    def confirmed_user
      @confirmed_user ||= begin
        user = create_user
        user.confirm
        user
      end
    end
  end
end
