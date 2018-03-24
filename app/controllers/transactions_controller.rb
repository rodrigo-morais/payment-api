class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all

    render json: @transactions, status: :ok
  end

  def show
    @transaction = Transaction.find(params[:id])

    render json: @transaction, status: :ok
  end
end
