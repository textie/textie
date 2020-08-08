require "rails_helper"

RSpec.describe "Api::V1::Users", type: :request do
  let(:body) { JSON.parse(response.body) }

  describe "POST /api/v1/users" do
    let(:request) { post api_v1_users_url, params: { user: user_attributes } }

    context "with valid attributes" do
      let(:user_attributes) { attributes_for(:user) }
      let(:request) { post api_v1_users_url, params: { user: user_attributes } }

      it "creates user" do
        expect { request }.to change(User, :count).by(1)
      end
    end

    context "when email already taken" do
      let(:user_attributes) { attributes_for(:user, email: "taken@email.com") }

      before { create(:user, email: "taken@email.com") }

      it "responds with errors" do
        request
        expect(body).to match("email" => [include("taken")])
      end
    end

    context "when no email provided or invalid email" do
      let(:user_attributes) { attributes_for(:user, email: "") }

      it "responds with errors" do
        request
        expect(body).to match("email" => [include("blank"), include("invalid")])
      end
    end

    context "when no password provided" do
      let(:user_attributes) { attributes_for(:user, password: "") }

      it "responds with errors" do
        request
        expect(body).to match("password" => [include("blank")])
      end
    end
  end
end
