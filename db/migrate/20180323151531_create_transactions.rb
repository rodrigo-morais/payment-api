class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions, id: :uuid do |t|
      t.integer :version
      t.uuid :organisation_id

      t.timestamps
    end
  end
end
