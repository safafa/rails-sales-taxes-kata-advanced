# frozen_string_literal: true

require 'test_helper'

class ConfirmationInstructionsTest < ActionMailer::TestCase
  SENDER_EMAIL = 'test@example.com'

  def setup
    setup_mailer
    Devise.mailer = 'Devise::Mailer'
    Devise.mailer_sender = SENDER_EMAIL
  end

  def teardown
    Devise.mailer = 'Devise::Mailer'
    Devise.mailer_sender = 'please-change-me@config-initializers-devise.com'
  end

  def user
    @user ||= create_user
  end

  def mail
    @mail ||= begin
      user
      ActionMailer::Base.deliveries.first
    end
  end

  test 'email sent after creating the user' do
    assert_not_nil mail
  end

  test 'content type should be set to html' do
    assert_includes mail.content_type, 'text/html'
  end

  test 'send confirmation instructions to the user email' do
    mail
    assert_equal [user.email], mail.to
  end

  test 'set up sender from configuration' do
    assert_equal [SENDER_EMAIL], mail.from
  end

  test 'body should have user info' do
    assert_match user.email, mail.body.encoded
  end

  test 'body should have link to confirm the account' do
    host, port = ActionMailer::Base.default_url_options.values_at :host, :port

    if mail.body.encoded =~ %r{<a href="http://#{host}:#{port}/users/confirmation\?confirmation_token=([^"]+)">}
      assert_equal user.confirmation_token, Regexp.last_match(1)
    else
      flunk 'expected confirmation url regex to match'
    end
  end
end
