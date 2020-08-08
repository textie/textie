require "rails_helper"

RSpec.describe LoginUser::AuthenticateByPassword do
  describe ".call" do
    subject(:result) { described_class.call(user: user, password: password) }

    let(:user) { create(:user, password: "123456") }

    context "when password is correct" do
      let(:password) { "123456" }

      it { is_expected.to be_a_success }

      it "authenticates user" do
      end
    end

    context "with incorrect password" do
      let(:password) { "" }

      it { is_expected.to be_a_failure }

      it "removes user from context" do
        expect(result.user).to be_nil
      end
    end
  end
end
