class TransactionSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :version, :organisation_id, :amount, :currency, :beneficiary_name, :beneficiary_account_number, :beneficiary_account_number_code, :beneficiary_bank_id, :beneficiary_bank_id_code, :debtor_name, :debtor_account_number, :debtor_account_number_code, :debtor_bank_id, :debtor_bank_id_code, :created_at, :updated_at, :status, :links

  def links
    {
      self: url_for(
        controller: 'transactions',
        action: 'show',
        host: 'localhost',
        port: '3000',
        id: object.id
      ),
      delete: url_for(
        controller: 'transactions',
        action: 'destroy',
        host: 'localhost',
        port: '3000',
        id: object.id
      )
    }
  end
end
