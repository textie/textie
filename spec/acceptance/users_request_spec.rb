require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.resource "/users" do
  include_context "with API request"

  post "/api/v1/users" do
    with_options scope: :user, with_example: true do
      parameter :email, required: true
      parameter :full_name
      parameter :password, required: true
    end

    let(:user_attributes) { { email: email, password: password } }
    let(:raw_post) { { user: user_attributes }.to_json }

    context "with valid attributes" do
      let(:user_attributes) { attributes_for(:user) }
      let(:response_attributes) do
        {
          "id" => be_instance_of(Integer),
          "fullName" => user_attributes[:full_name],
          "email" => user_attributes[:email]
        }
      end
      let(:raw_post) { { user: user_attributes }.to_json }

      example "creates user" do
        expect { do_request }.to change(User, :count).by(1)
        expect(response_body).to match_json(user: response_attributes)
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
