require "rails_helper"

RSpec.describe "Transcation API", :type => :request do
  let!(:my_transaction) { create :transaction }

  context "#index" do
    it "responds with 200" do
      get "/transactions"
      expect(response).to be_success
    end

    it "responds with transaction data" do
      get "/transactions"
      expect(response.body).to include(my_transaction.to_json)
    end
  end

  context "#show" do
    it "responds with 200" do
      get "/transactions/#{my_transaction.id}"
      expect(response.status).to eq(200)
    end

    it "responds with transaction data" do
      get "/transactions/#{my_transaction.id}"
      expect(response.body).to include(my_transaction.to_json)
    end
  end
end
