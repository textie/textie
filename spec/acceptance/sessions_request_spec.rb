require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.resource "Api::V1::Sessions" do
  include_context "with API request"

  post "/api/v1/sessions" do
    with_options scope: :session, with_example: true do
      parameter :email, required: true
      parameter :password, required: true
    end

    let(:email) { "email@sessions.spec" }
    let(:password) { "123456" }

    context "with valid credentials" do
      before { create(:user, email: email, password: password) }

      example_request "responds with token" do
        expect(response).to include(token: match(/^eyJ.+\..+\..+$/))
      end
    end

    context "with invalid credentials" do
      example_request "responds with error" do
        expect(response).to include(error: include("Invalid credentials"))
      end
    end
  end
end
