class TransactionsController < ApplicationController
  before_action :authenticate_token
  after_action -> { set_pagination_headers :transactions }, only: [:index]

  def index
    @transactions = Transaction.page(page).per(per_page)

    render json: @transactions,
                 root: "data",
                 meta: pagination_meta(@transactions),
                 meta_key: "links",
                 adapter: :json,
                 status: :ok

    rescue Exception => e
      render json: {
        status: 500,
        error: "Internal server error",
        message: e.to_s
      }, status: 500
  end

  def show
    @transaction = Transaction.find(params[:id])

    render json: @transaction, status: :ok

    rescue ActiveRecord::RecordNotFound => e
      render json: {
        status: 404,
        error: :not_found,
        message: e.to_s
      }, status: :not_found
  end

  def create
    transaction = Transaction.new(transaction_params)

    transaction.save!

    render json: transaction, status: :created

    rescue Exception => e
      render json: {
        status: 400,
        error: :bad_request,
        message: e.to_s
      }, status: :bad_request
  end

  def destroy
    @transaction = Transaction.find(params[:id])

    @transaction.update_attributes(status: "CANCELED")

    render status: :ok

    rescue ActiveRecord::RecordNotFound => e
      render json: {
        status: 404,
        error: :not_found,
        message: e.to_s
      }, status: :not_found
  end

  private

  def authenticate_token
    if request.headers["Authorization"] != "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlLW1haWwiOiJtb3JhaXMucm1AZ21haWwuY29tIiwibmFtZSI6IlJvZHJpZ28gTW9yYWlzIiwidXVpZCI6MTIzM30.tib1NtKu0wUE1N9ISBDmfh-DOdSDD33yXq_E3XLEZWg"
      render json: {
        status: 401,
        error: :unauthorized,
        message: "Unathorized",
      }, status: :unauthorized
    end
  end

  def transaction_params
    params.permit(
      :version,
      :organisation_id,
      :amount,
      :currency,
      :beneficiary_name,
      :beneficiary_account_number,
      :beneficiary_account_number_code,
      :beneficiary_bank_id,
      :beneficiary_bank_id_code,
      :debtor_name,
      :debtor_account_number,
      :debtor_account_number_code,
      :debtor_bank_id,
      :debtor_bank_id_code
    )
  end
end
