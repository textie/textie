require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.resource "Api::V1::Profiles" do
  get "/api/v1/profile" do
    let(:user) { create(:user) }
    let(:jwt) { LoginUser::GenerateJwt.call(user: user).token }
    let(:user_attributes) do
      {
        "id" => user.id,
        "email" => user.email,
        "fullName" => user.full_name
      }
    end

    context "with valid authentication" do
      before { header "Authorization", "JWT #{jwt}" }

      example_request "returns current user's profile" do
        expect(response_body).to match_json("user" => user_attributes)
      end
    end

    context "with invalid authentication" do
      header "Authorization", "xyz"

      example_request "response with unauthorized status" do
        expect(status).to eq(401)
      end
    end
  end
end
