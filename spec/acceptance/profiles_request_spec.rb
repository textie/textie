require "rails_helper"

RSpec.describe "Api::V1::Profiles", type: :request do
  include_context "with API request"

  describe "GET /api/v1/profile" do
    let(:user) { create(:user) }
    let(:jwt) { LoginUser::GenerateJwt.call(user: user).token }
    let(:headers) { { "Authorization" => "JWT #{jwt}" } }
    let(:do_request) { get "/api/v1/profile", headers: headers }
    let(:user_attributes) do
      {
        "id" => user.id,
        "email" => user.email,
        "fullName" => user.full_name
      }
    end

    it "returns current user's profile" do
      expect(response_body).to match("user" => user_attributes)
    end

    context "with invalid authentication" do
      let(:headers) { { "Authentication" => "xyz" } }

      it "response with unauthorized status" do
        do_request
        expect(response).to be_unauthorized
      end
    end
  end
end
