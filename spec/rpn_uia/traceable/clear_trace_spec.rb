# frozen_string_literal: true

require_relative "trace_spec_helper"

RSpec.describe RpnUIA::Traceable, "#clear" do
  let(:dummy) { Dummy.new }

  context "when there is one trace" do
    it "clears the trace" do
      dummy.state = "Running"
      dummy.save_state
      dummy.clear_state
      expect(dummy.state_traces).to eq []
    end
  end

  context "when there are more than one trace" do
    it "still clears the trace" do
      dummy.state = "Running"
      dummy.save_state
      dummy.state = "Sleeping"
      dummy.save_state

      dummy.clear_state
      expect(dummy.state_traces).to eq []
    end
  end
end
