# frozen_string_literal: true

class ReceiptsController < ApplicationController
  before_action :check_authentication, only: [:index, :show]
  before_action :set_receipt, only: [:show]

  def index
    @receipts = current_user.receipts
  end

  def show; end

  private

  def set_receipt
    @receipt = current_user.receipts.find_by(id: params[:id])
    redirect_to root_path unless @receipt
  end

  def check_authentication
    redirect_to root_path unless user_signed_in?
  end
end
