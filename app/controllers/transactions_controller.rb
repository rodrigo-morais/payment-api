class TransactionsController < ApplicationController
  after_action -> { set_pagination_headers :transactions }, only: [:index]

  def index
    @transactions = Transaction.page(page).per(per_page)

    render json: @transactions, status: :ok
  end

  def show
    @transaction = Transaction.find(params[:id])

    render json: @transaction, status: :ok
  end
end
