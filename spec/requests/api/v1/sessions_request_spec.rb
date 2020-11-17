require "rails_helper"

RSpec.describe "Api::V1::Sessions", type: :request do
  include_context "with API request"

  describe "POST /api/v1/sessions" do
    let(:credentials) { { email: "email@sessions.spec", password: "123456" } }
    let(:headers) { { "Content-Type" => "application/json" } }
    let(:do_request) do
      post "/api/v1/sessions", params: { session: credentials }.to_json, headers: headers
    end

    context "with valid credentials" do
      before { create(:user, credentials) }

      it "responds with token" do
        expect(response_body).to match("token" => match(/^eyJ.+\..+\..+$/))
      end
    end

    context "with invalid credentials" do
      let(:credentials) { { email: "fake@email.spec", password: "fake_pw" } }

      it "responds with error" do
        expect(response_body).to match("error" => include("Invalid credentials"))
      end
    end
  end
end
