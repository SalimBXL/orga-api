require 'rails_helper'

RSpec.describe "Postits", type: :request do

  describe "GET /postits" do

    before { 
      FactoryBot.create_list :postit, 3
      get "/postits"
    }

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns all the entries" do 
      expect(parsed_body.count).to eq Postit.all.count
    end

  end



  describe "GET /postits/:id" do

    let(:postit) { FactoryBot.create :postit }

    before { get "/postits/#{postit.id}" }

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "is correctly serialized" do
      expect(parsed_body['title']).to eq postit.title
      expect(parsed_body['body']).to eq postit.body
      expect(parsed_body['level']).to eq postit.level
    end


  end
end
