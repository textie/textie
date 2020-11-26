require "rails_helper"

RSpec.describe LoginUser::AuthenticateUser do
  describe ".call" do
    subject(:result) do
      described_class.call(email: user.email, password: password)
    end

    let(:user) { create(:user, password: "123456") }
    let(:password) { "123456" }

    it { is_expected.to be_a_success }

    it "authenticates user" do
      expect(result.user).to eq(user)
    end

    context "with incorrect password" do
      let(:password) { "9876" }

      it { is_expected.to be_a_failure }

      it "hides user from context" do
        expect(result.user).not_to be_a(User)
      end

      it "explains what happened" do
        expect(result.error).to include("Invalid credentials")
      end
    end
  end
end
