# frozen_string_literal: true

require_relative "trace_spec_helper"

RSpec.describe RpnUIA::Traceable, "#any_previous?" do
  let(:dummy) { Dummy.new }

  context "when there is no trace" do
    it "returns false" do
      expect(dummy.any_previous_state?).to eq false
    end
  end

  context "when there is a trace" do
    it "returns true" do
      dummy.state = "Running"
      dummy.save_state
      expect(dummy.any_previous_state?).to eq true
    end
  end
end
