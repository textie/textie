require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.resource "Api::V1::Users" do
  include_context "with API request"

  post "/api/v1/users" do
    with_options scope: :user, with_example: true do
      parameter :email, required: true
      parameter :full_name
      parameter :password, required: true
    end

    let(:user_attributes) { attributes_for(:user) }
    let(:response_attributes) do
      {
        "id" => be_instance_of(Integer),
        "fullName" => user_attributes[:full_name],
        "email" => user_attributes[:email]
      }
    end

    example "creates user" do
      expect { do_request(user: user_attributes) }.to(
        change(User, :count).by(1)
      )
      expect(response_body).to match_json(user: response_attributes)
    end

    RSpec.shared_examples "error response" do |errors_hash|
      let(:errors_matcher) do
        errors_hash.transform_values do |errors|
          errors.map { |e| include(e) }
        end
      end

      example_request "responds with errors" do
        expect(response_body).to match_json(errors: errors_matcher)
      end
    end

    context "when email already taken" do
      let(:email) { "taken@email.com" }
      let(:password) { "123456" }

      before { create(:user, email: "taken@email.com") }

      it_behaves_like "error response", "email" => ["taken"]
    end

    context "when no email provided or invalid email" do
      let(:email) { "" }
      let(:password) { "123456" }

      it_behaves_like "error response", "email" => %w[blank invalid]
    end

    context "when no password provided" do
      let(:email) { "linus.torvalds@gmail.com" }
      let(:password) { "" }

      it_behaves_like "error response", "password" => ["blank"]
    end
  end
end
