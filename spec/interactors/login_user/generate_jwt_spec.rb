require "spec_helper"

RSpec.describe LoginUser::GenerateJwt do
  subject(:result) { described_class.call(user: user) }

  let(:user) { create(:user) }
  let(:fake_codec) { instance_double(JwtCodec) }

  before do
    allow(JwtCodec).to receive(:new).and_return(fake_codec)
    allow(fake_codec).to receive(:encode).and_return("8")
  end

  it { is_expected.to be_a_success }

  it "invokes jwt codec" do
    result
    expect(fake_codec).to have_received(:encode)
  end

  it "exposes token" do
    expect(result.token).to eq("8")
  end
end
