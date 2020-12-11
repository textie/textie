RSpec.shared_context "when time is frozen" do |time|
  let(:current_time) { time || Time.current }

  before { Timecop.freeze(current_time) }

  after { Timecop.return }
end
