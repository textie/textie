require "rails_helper"

RSpec.describe RefreshAuthentication::FindUserByRefreshToken do
  subject(:call) { described_class.call(refresh_token: "a.b.c") }

  let(:token_created_at) { 1.hour.ago }
  let(:refresh_token) { create(:refresh_token, created_at: token_created_at) }
  let(:fake_codec) { instance_double(JwtService) }

  before do
    allow(JwtService).to receive(:new).and_return(fake_codec)
    allow(fake_codec).to receive(:decode).with("a.b.c")
      .and_return("id" => refresh_token.id)
  end

  it { is_expected.to be_a_success }

  it "destroys the refresh token" do
    expect { call }.to change(RefreshToken, :count).by(-1)
  end

  it "exposes user" do
    expect(call).to have_attributes(user: refresh_token.user)
  end

  context "with expired token" do
    let(:token_created_at) { 2.years.ago }

    it { is_expected.to be_a_failure }

    it "expose the error" do
      expect(call).to have_attributes(error: include("expired"))
    end
  end

  context "with invalid token" do
    before do
      allow(fake_codec).to receive(:decode).and_return(nil)
    end

    it { is_expected.to be_a_failure }

    it "expose the error" do
      expect(call).to have_attributes(error: "Invalid authentication token")
    end
  end

  context "with already used token" do
    before { described_class.call(refresh_token: "a.b.c") }

    it { is_expected.to be_a_failure }

    it "expose the error" do
      expect(call).to have_attributes(error: "Invalid authentication token")
    end
  end
end
