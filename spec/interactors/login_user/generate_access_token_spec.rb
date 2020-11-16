require "spec_helper"

RSpec.describe LoginUser::GenerateAccessToken do
  include_context "when time is frozen", Time.utc("2005-07-14 16:42:01 UTC")

  subject(:result) { described_class.call(user: user) }

  let(:user) { create(:user, id: 83_437_173) }
  let(:fake_codec) { instance_double(JwtService) }

  before do
    allow(JwtService).to receive(:new).and_return(fake_codec)
    allow(fake_codec).to receive(:encode).and_return("8")
  end

  it { is_expected.to be_a_success }

  it "encodes user id and current timestamp to JWT" do
    result
    expect(fake_codec).to have_received(:encode).with(
      sub: 83_437_173,
      iat: 1_104_537_600
    )
  end

  it "exposes token" do
    expect(result.access_token).to eq("8")
  end
end
