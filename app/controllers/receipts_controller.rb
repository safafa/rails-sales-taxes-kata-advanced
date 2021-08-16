# frozen_string_literal: true

class ReceiptsController < ApplicationController
  before_action :check_authentication, only: [:new, :create, :index, :show]
  before_action :set_receipt, only: [:show]

  def new
    @receipt = Receipt.new
  end

  def create
    receipt_file = params[:receipt][:uploaded_receipt]
    @receipt = current_user.create_receipt_from_file(receipt_file)

    if @receipt&.errors&.any?
      render :new
    else
      redirect_to @receipt
    end
  end

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
