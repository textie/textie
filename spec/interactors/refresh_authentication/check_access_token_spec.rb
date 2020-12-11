require "rails_helper"

RSpec.describe RefreshAuthentication::CheckAccessToken do
  subject(:call) { described_class.call(access_token: "a.b.c", user: user) }

  let(:token_created_at) { 1.hour.ago }
  let(:fake_codec) { instance_double(JwtService) }
  let(:user) { create(:user) }
  let(:issued_at) { 1.minute.ago.utc.to_i }
  let(:user_id) { user.id }

  before do
    allow(JwtService).to receive(:new).and_return(fake_codec)
    allow(fake_codec).to receive(:decode)
      .with("a.b.c")
      .and_return("sub" => user_id, "iat" => issued_at)
  end

  it { is_expected.to be_a_success }

  context "with expired token" do
    let(:issued_at) { 1.year.ago.utc.to_i }

    it { is_expected.to be_a_success }
  end

  context "with another user" do
    let(:user_id) { user.id + 1 }

    it { is_expected.to be_a_failure }

    it "says that token is invalid" do
      expect(call.error).to include("Invalid authentication")
    end
  end
end
