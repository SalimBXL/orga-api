require 'rails_helper'
require 'pp'

RSpec.describe "Postits", type: :request do

  let(:postit) { FactoryBot.create(:postit, user_id: current_user.id) }

  describe "GET /postits" do
    context "when everything goes well" do
      let(:page) { 3 }
      let(:per_page) { 5 }
      before { 
        FactoryBot.create_list(:postit, 21)
        get "/v2/postits", params: { page: page, per_page: per_page }
      }

      it "works" do
        expect(response).to have_http_status :partial_content
      end

      it "returns paginated results" do 
        expect(parsed_body.map{ |p| p['id'] }).to eq Postit.all.limit(per_page).offset((page - 1) * per_page).pluck(:id)
      end
    end

    it "returns a bad request when parameters are missing" do
      get "/v2/postits"
      expect(response).to have_http_status :bad_request
      expect(parsed_body.keys).to include 'error'
      expect(parsed_body['error']).to eq 'missing parameters'
    end
  end

  describe "GET /postits/:id" do
    context "when everything goes well" do
      before { get "/v2/postits/#{postit.id}" }

      it "works" do
        expect(response).to have_http_status(200)
      end

      it "is correctly serialized" do
        expect(parsed_body).to match({
          id: postit.id,
          title: postit.title,
          body: postit.body,
          level: postit.level,
          user: {
            id: postit.user.id,
            fullname: postit.user.fullname
          }.stringify_keys
        }.stringify_keys)
      end
    end

    it "returns not found when te resource can not be found" do
      get "/v2/postits/0"
      expect(response).to have_http_status :not_found
    end
  end

  describe "POST /postits" do
    context "when unauthenticated" do
      it "returns unauthenticated" do
        post "/v2/postits"
        expect(response).to have_http_status :unauthorized
      end
    end

    context "when authenticated" do
      let(:params) { { postit: { title: "title", body: "body", level: 0 } } }
      before { post "/v2/postits", params: params, headers: authentication_header }

      it "works" do
        expect(response).to have_http_status :created
      end

      it "creates a new postit" do
        expect {
          post "/v2/postits", params: params, headers: authentication_header
        }.to change {
          current_user.postits.count
        }.by 1
      end

      it "has correct fields values for the created postit" do
        post "/v2/postits", params: params, headers: authentication_header
        created_postit = current_user.postits.last
        expect(created_postit.title).to eq "title"
        expect(created_postit.body).to eq "body"
        expect(created_postit.level).to eq 0
      end

      it "return a bad request when a parameter is missing" do
        params[:postit].delete(:level)
        post "/v2/postits", params: params, headers: authentication_header
        expect(response).to have_http_status :bad_request
      end

      it "return a bad request when a parameter has the wrong type" do
        params[:postit][:level] = "test"
        post "/v2/postits", params: params, headers: authentication_header
        expect(response).to have_http_status :bad_request
      end
    end
  end

  describe "PATCH /postits/:id" do
    let(:params) { { postit: { title: "A new title", level: 1 } } }
    context "when unauthenticated" do
      it "returns unauthenticated" do
        patch "/v2/postits/#{postit.id}"
        expect(response).to have_http_status :unauthorized
      end
    end

    context "when authenticated" do
      context "when everything goes well" do
        before { patch "/v2/postits/#{postit.id}", params: params, headers: authentication_header }

        it { expect(response).to have_http_status :success }

        it "modifies the given fields of the ressource" do
          modified_postit = Postit.find(postit.id)
          expect(modified_postit.title).to eq "A new title"
          expect(modified_postit.level).to eq 1
        end
      end

      it "return a bad request when a parameter is malformed" do
        params[:postit][:level] = "test"
        patch "/v2/postits/#{postit.id}", params: params, headers: authentication_header
        expect(response).to have_http_status :bad_request
      end

      it "returns a not found when resource can not be found" do
        patch "/v2/postits/0", params: params, headers: authentication_header
        expect(response).to have_http_status :not_found
      end
      
      it "returns a forbidden when requester is not the owner of the resource" do
        another_postit = FactoryBot.create(:postit)
        patch "/v2/postits/#{another_postit.id}", params: params, headers: authentication_header
        expect(response).to have_http_status :forbidden
      end
    end
  end

  describe "DELETE /postits/:id" do
    context "when unauthenticated" do

      it "returns unauthorized" do
        delete "/v2/postits/#{postit.id}"
        expect(response).to have_http_status :unauthorized
      end
    end

    context "when authenticated" do
      context "when everything goes well" do
        before { delete "/v2/postits/#{postit.id}", headers: authentication_header }

        it { expect(response).to have_http_status :no_content }

        it "deletes the given postit" do
          expect(Postit.find_by(id: postit.id)).to eq nil
        end
      end

      it "returns a not found when resource can not be found" do
        delete "/v2/postits/0", headers: authentication_header
        expect(response).to have_http_status :not_found
      end

      it "returns a forbidden when requester is not the owner of the resource" do
        another_postit = FactoryBot.create(:postit)
        delete "/v2/postits/#{another_postit.id}", headers: authentication_header
        expect(response).to have_http_status :forbidden
      end
    end
  end
end
