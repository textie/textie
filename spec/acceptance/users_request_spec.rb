require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.resource "Users" do
  post "/api/v1/users" do
    with_options scope: :user, with_example: true do
      parameter :email, required: true
      parameter :full_name, required: true
      parameter :password, required: true
    end

    let(:email) { "john.smith@example.spec" }
    let(:full_name) { "John Smith" }
    let(:password) { "123456" }

    example_request "Register/sign up" do
      expect(response_status).to eq(201)
      expect(response).to include(
        user: {
          "id" => be_instance_of(Integer),
          "fullName" => "John Smith",
          "email" => "john.smith@example.spec"
        }
      )
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
