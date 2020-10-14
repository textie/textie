require "rails_helper"

RSpec.describe "Api::V1::Users", type: :request do
  include_context "with API request"

  describe "POST /api/v1/users" do
    let(:do_request) do
      post api_v1_users_url, params: { user: user_attributes }
    end

    let(:user_attributes) { attributes_for(:user) }
    let(:response_attributes) do
      {
        "id" => be_instance_of(Integer),
        "fullName" => user_attributes[:full_name],
        "email" => user_attributes[:email]
      }
    end

    it "creates user" do
      expect { do_request }.to change(User, :count).by(1)
    end

    it "returns created user attributes" do
      expect(response_body).to match("user" => response_attributes)
    end

    RSpec.shared_examples "error response" do |errors_hash|
      let(:errors_matcher) do
        errors_hash.transform_values do |errors|
          errors.map { |e| include(e) }
        end
      end

      it "responds with errors" do
        expect(response_body).to match("errors" => errors_matcher)
      end
    end

    context "when email already taken" do
      let(:user_attributes) do
        attributes_for(:user, email: "taken@email.com")
      end

      before { create(:user, email: "taken@email.com") }

      it_behaves_like "error response", "email" => ["taken"]
    end

    context "when no email provided or invalid email" do
      let(:user_attributes) { attributes_for(:user, email: "") }

      it_behaves_like "error response", "email" => %w[blank invalid]
    end

    context "when no password provided" do
      let(:user_attributes) { attributes_for(:user, password: "") }

      it_behaves_like "error response", "password" => ["blank"]
    end
  end
end
