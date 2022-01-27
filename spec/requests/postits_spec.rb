require 'rails_helper'

RSpec.describe "Postits", type: :request do
  describe "GET /postits/:id" do
    it "works!" do
      postit = FactoryBot.create :postit
      get "/postits/#{postit.id}"
      expect(response).to be_success
    end
  end
end
