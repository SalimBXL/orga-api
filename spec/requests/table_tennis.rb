require 'rails_helper'

RSpec.describe "Table Tennis", type: :request do
  describe "#ping" do
    
    context "when unauthenticated" do

      before { get "/ping" }

      it "works" do
        expect(response).to have_http_status(200)
      end

      it "returns unauthorized pong" do 
        expect(parsed_body['response']).to eq "unauthorized pong"
      end
    end

    context "when authenticated" do

      before { get "/ping", headers: authentication_header }

      it "works" do
        expect(response).to have_http_status(200)
      end

      it "returns authorized pong" do
        expect(parsed_body['response']).to eq "authorized pong"
      end
    end
  end
end