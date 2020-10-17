require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.resource "Api::V1::Sessions" do
  header "Content-Type", "application/json"

  post "/api/v1/sessions" do
    with_options with_example: true do
      parameter :email, required: true
      parameter :password, required: true
    end

    let(:email) { "email@sessions.spec" }
    let(:password) { "123456" }
    let(:credentials) { { email: email, password: password } }
    let(:raw_post) {  credentials.to_json }

    before { create(:user, credentials) }

    example_request "responds with token" do
      expect(response_body).to match_json("token" => match(/^eyJ.+\..+\..+$/))
    end

    context "with invalid credentials" do
      let(:credentials) { {} }

      example_request "responds with error" do
        expect(response_body).to match_json("error" => include("Invalid credentials"))
      end
    end
  end
end
