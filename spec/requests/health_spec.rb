require "rails_helper"

RSpec.describe "Health Check", :type => :request do
  it "responds with 200" do
    get "/health"
    expect(response).to be_success
  end
end
