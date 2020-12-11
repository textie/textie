require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.resource "Sessions" do
  post "/api/v1/session" do
    with_options scope: :session, with_example: true do
      parameter :email, required: true
      parameter :password, required: true
    end

    let(:email) { "email@sessions.spec" }
    let(:password) { "123456" }

    context "with valid credentials" do
      before { create(:user, email: email, password: password) }

      example_request "Create a session/sign in/log in" do
        expect(status).to eq(200)
        expect(body).to include(
          access_token: match(/^eyJ.+\..+\..+$/)
        )
        expect(cookies).to include(
          refresh_token: match(/^eyJ.+\..+\..+$/)
        )
      end
    end

    context "with invalid credentials" do
      example_request "Get rejected with invalid credentials" do
        expect(status).to eq(401)
        expect(body).to include(error: include("Invalid credentials"))
      end
    end
  end

  patch "/api/v1/session" do
    with_options scope: :session, with_example: true do
      parameter :access_token, required: true
    end

    before do
      header "Cookie", "refresh_token=#{refresh_token}"
    end

    let(:user) { create(:user) }
    let(:access_token) do
      LoginUser::GenerateAccessToken.call(user: user).access_token
    end
    let(:refresh_token) do
      RefreshAuthentication::CreateRefreshToken.call(user: user).refresh_token
    end

    context "with valid credentials" do
      example_request "Refresh session/authentication/jwt" do
        expect(status).to eq(200)
        expect(body).to include(
          access_token: match(/^eyJ.+\..+\..+$/)
        )
        expect(cookies).to include(
          refresh_token: match(/^eyJ.+\..+\..+$/)
        )
      end
    end

    context "with invalid access_token" do
      let(:refresh_token) { "e.3.j" }

      example_request "Try to refesh session with invalid refesh token" do
        expect(status).to eq(401)
      end
    end
  end
end
