require "rails_helper"

RSpec.describe "Api::V1::Users", type: :request do
  let(:body) { JSON.parse(response.body) }

  describe "POST /api/v1/users" do
    let(:request) { post api_v1_users_url, params: { user: user_attributes } }

    context "with valid attributes" do
      let(:valid_attributes) { attributes_for(:user) }
      let(:do_request) do
        post api_v1_users_url, params: { user: valid_attributes }
      end
      let(:response_attributes) do
        {
          "id" => be_instance_of(Integer),
          "fullName" => valid_attributes[:full_name],
          "email" => valid_attributes[:email]
        }
      end

      it "creates user" do
        expect { do_request }.to change(User, :count).by(1)
      end

      it "returns created user attributes" do
        do_request
        expect(body).to match("user" => response_attributes)
      end
    end

    context "with invalid attributes" do
      let(:do_request) do
        post api_v1_users_url, params: { user: invalid_attributes }
      end

      RSpec.shared_examples "error response" do |errors_hash|
        let(:errors_matcher) do
          errors_hash.transform_values do |errors|
            errors.map { |e| include(e) }
          end
        end

        it "responds with errors" do
          do_request
          expect(body).to match("errors" => errors_matcher)
        end
      end

      context "when email already taken" do
        let(:invalid_attributes) do
          attributes_for(:user, email: "taken@email.com")
        end

        before { create(:user, email: "taken@email.com") }

        it_behaves_like "error response", "email" => ["taken"]
      end

      context "when no email provided or invalid email" do
        let(:invalid_attributes) { attributes_for(:user, email: "") }

        it_behaves_like "error response", "email" => %w[blank invalid]
      end

      context "when no password provided" do
        let(:invalid_attributes) { attributes_for(:user, password: "") }

        it_behaves_like "error response", "password" => ["blank"]
      end
    end
  end
end
