# frozen_string_literal: true

class ReceiptsController < ApplicationController
  before_action :check_authentication, only: [:index]

  def index
    @receipts = current_user.receipts
  end

  private

  def check_authentication
    redirect_to root_path unless user_signed_in?
  end
end
