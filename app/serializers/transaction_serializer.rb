class TransactionSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :version, :organisation_id, :created_at, :updated_at, :status, :links

  def links
    {
      self: url_for(
        controller: 'transactions',
        action: 'show',
        host: 'localhost',
        port: '3000',
        id: object.id
      )
    }
  end
end
