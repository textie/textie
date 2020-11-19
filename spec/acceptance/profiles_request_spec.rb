require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.resource "Profiles" do
  get "/api/v1/profile" do
    let(:user) do
      create :user, full_name: "John Smith", email: "john.smith@example.com"
    end
    let(:jwt) { LoginUser::GenerateJwt.call(user: user).token }
    let(:user_attributes) do
      {
        "id" => user.id,
        "email" => "john.smith@example.com",
        "fullName" => "John Smith"
      }
    end

    context "with valid authentication" do
      before { header "Authorization", "JWT #{jwt}" }

      example_request "Get current user's info" do
        expect(response).to include(user: user_attributes)
      end
    end

    context "with invalid authentication" do
      header "Authorization", "xyz"

      example_request "Get rejected with invalid authentication" do
        expect(status).to eq(401)
      end
    end
  end
end
