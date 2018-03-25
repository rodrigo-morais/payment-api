require "rails_helper"

RSpec.describe "Transcation API", :type => :request do
  let(:token) do
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlLW1haWwiOiJtb3JhaXMucm1AZ21haWwuY29tIiwibmFtZSI6IlJvZHJpZ28gTW9yYWlzIiwidXVpZCI6MTIzM30.tib1NtKu0wUE1N9ISBDmfh-DOdSDD33yXq_E3XLEZWg"
  end
  let(:headers) do
    {
      "AUTHORIZATION" => token
    }
  end

  def get_auth(path)
    get path, headers: headers
  end

  def post_auth(path, params)
    post "/transactions", params: params, headers: headers
  end

  def cancel_auth(path)
    delete path, headers: headers
  end

  context "with transaction" do
    let!(:my_transaction) { create :transaction }
    let(:transaction_json) do
      TransactionSerializer.new(my_transaction)
    end

    context "#index" do
      it "responds with 200" do
        get_auth("/transactions")
        expect(response).to be_success
      end

      it "responds with transaction data" do
        get_auth("/transactions")
        expect(response.body).to include(transaction_json.to_json)
      end

      it "responds with x-total-count in headers" do
        get_auth("/transactions")
        expect(response.headers['X-TOTAL-COUNT']).to eq(1)
      end

      it "contains LINK in headers" do
        get_auth("/transactions")
        expect(response.headers['LINK']).to include("rel='current'")
        expect(response.headers['LINK']).to include("page=1")
      end
    end

    context "#show" do
      it "responds with 200" do
        get_auth("/transactions/#{my_transaction.id}")
        expect(response.status).to eq(200)
      end

      it "responds with 404" do
        get_auth("/transactions/9999")
        expect(response.status).to eq(404)
      end

      it "responds with transaction data" do
        get_auth("/transactions/#{my_transaction.id}")
        expect(response.body).to include(transaction_json.to_json)
      end
    end
  end

  context "without transaction" do
    context "#index" do
      it "responds with 200" do
        get_auth("/transactions")
        expect(response).to be_success
      end

      it "responds with transaction data" do
        get_auth("/transactions")
        expect(JSON.parse(response.body)["data"]).to be_empty
      end

      it "responds with x-total-count in headers" do
        get_auth("/transactions")
        expect(response.headers['X-TOTAL-COUNT']).to eq(0)
      end

      it "does not contain LINK in headers" do
        get_auth("/transactions")
        expect(response.headers['LINK']).to be_nil
      end
    end
  end

  context "create transaction" do
    let!(:my_org) { create :organisation }
    let(:new_transaction) do
      {
        version: 0,
        organisation_id: my_org.id
      }
    end
    let(:wrong_transaction) do
      {
        version: 0,
        organisation_id: "wrong"
      }
    end

    it "returns 201 for a valid transaction" do
      post_auth("/transactions", new_transaction)
      expect(response.status).to eq(201)
    end

    it "returns the new transaction" do
      post_auth("/transactions", new_transaction)
      transaction = TransactionSerializer.new(Transaction.last)
      expect(response.body).to include(transaction.to_json)
    end

    it "returns 400 for an invalid transaction" do
      post_auth("/transactions", wrong_transaction)
      expect(response.status).to eq(400)
    end
  end

  context "cancel transaction" do
    let!(:my_transaction) { create :transaction }

    it "responds with 200" do
      cancel_auth("/transactions/#{my_transaction.id}")
      expect(response.status).to eq(200)
    end

    it "changes transaction status to CANCELED" do
      expect {
        cancel_auth("/transactions/#{my_transaction.id}")
      }.to change {
        my_transaction.reload.status
      }.from("CREATED").to("CANCELED")
    end

    it "responds with 400 if transaction does not exist" do
      cancel_auth("/transactions/9999")
      expect(response.status).to eq(404)
    end
  end
end
