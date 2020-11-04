RSpec.shared_context "when time is frozen" do
  let(:current_time) { Time.current }

  before { Timecop.freeze(current_time) }

  after { Timecop.return }
end
