require "rails_helper"

RSpec.describe "Transcation API", :type => :request do
  context "with transaction" do
    let!(:my_transaction) { create :transaction }
    let(:transaction_json) do
      TransactionSerializer.new(my_transaction)
    end

    context "#index" do
      it "responds with 200" do
        get "/transactions"
        expect(response).to be_success
      end

      it "responds with transaction data" do
        get "/transactions"
        expect(response.body).to include(transaction_json.to_json)
      end

      it "responds with x-total-count in headers" do
        get "/transactions"
        expect(response.headers['X-TOTAL-COUNT']).to eq(1)
      end

      it "contains LINK in headers" do
        get "/transactions"
        expect(response.headers['LINK']).to include("rel='current'")
        expect(response.headers['LINK']).to include("page=1")
      end
    end

    context "#show" do
      it "responds with 200" do
        get "/transactions/#{my_transaction.id}"
        expect(response.status).to eq(200)
      end

      it "responds with 404" do
        get "/transactions/9999"
        expect(response.status).to eq(404)
      end

      it "responds with transaction data" do
        get "/transactions/#{my_transaction.id}"
        expect(response.body).to include(transaction_json.to_json)
      end
    end
  end

  context "without transaction" do
    context "#index" do
      it "responds with 200" do
        get "/transactions"
        expect(response).to be_success
      end

      it "responds with transaction data" do
        get "/transactions"
        expect(JSON.parse(response.body)["transactions"]).to be_empty
      end

      it "responds with x-total-count in headers" do
        get "/transactions"
        expect(response.headers['X-TOTAL-COUNT']).to eq(0)
      end

      it "does not contain LINK in headers" do
        get "/transactions"
        expect(response.headers['LINK']).to be_nil
      end
    end
  end
end
