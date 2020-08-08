require "rails_helper"

RSpec.describe LoginUser::FindUserByEmail do
  describe ".call" do
    subject(:result) { described_class.call(email: email) }

    let(:email) { "found_user@example.com" }

    context "when user exists" do
      let!(:user) { create(:user, email: email) }

      it { is_expected.to be_a_success }

      it "finds user" do
        expect(result.user).to eq(user)
      end
    end

    context "when there is no such user" do
      it { is_expected.to be_a_failure }
    end
  end
end
