# frozen_string_literal: true

require_relative "trace_spec_helper"

RSpec.describe RpnUIA::Traceable, "#restore_previous_state" do
  let(:dummy) { Dummy.new }

  context "when there is a trace" do
    before do
      dummy.state = "Running"
      dummy.save_state
    end

    it "pops the trace" do
      expect(dummy.state_trace).to eq ["Running"]
      dummy.restore_previous_state
      expect(dummy.state_trace).to eq []
    end

    it "replaces the current state" do
      dummy.state = "Sleeping"
      dummy.restore_previous_state
      expect(dummy.state).to eq "Running"
    end
  end

  context "when there is no trace" do
    it "raises NoTraceFoundError" do
      expect {
        dummy.restore_previous_state
      }.to raise_error(RpnUIA::NoTraceFoundError)
    end
  end
end
