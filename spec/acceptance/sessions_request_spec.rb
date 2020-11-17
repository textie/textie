require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.resource "Sessions" do
  post "/api/v1/sessions" do
    with_options scope: :session, with_example: true do
      parameter :email, required: true
      parameter :password, required: true
    end

    let(:email) { "email@sessions.spec" }
    let(:password) { "123456" }

    context "with valid credentials" do
      before { create(:user, email: email, password: password) }

      example_request "Create a session/sign in/log in" do
        expect(response).to include(token: match(/^eyJ.+\..+\..+$/))
      end
    end

    context "with invalid credentials" do
      example_request "Get rejected with invalid credentials" do
        expect(response).to include(error: include("Invalid credentials"))
      end
    end
  end
end
