# frozen_string_literal: true

require_relative "trace_spec_helper"

RSpec.describe RpnUIA::Traceable, "#save_trace" do
  context "with :state" do
    let(:dummy) { Dummy.new }

    it "saves its state" do
      dummy.state = "Running"
      dummy.save_state
      expect(dummy.state_traces).to eq ["Running"]

      dummy.state = "Sleeping"
      dummy.save_state
      expect(dummy.state_traces).to eq %w[Running Sleeping]
    end
  end

  context "with :state and :feeling" do
    subject { Cat.new }

    it "does not mixed up the two" do
      subject.state = "Running"
      subject.save_state

      subject.feeling = "Happy"
      subject.save_feeling

      expect(subject.state_traces).to eq ["Running"]
      expect(subject.feeling_traces).to eq ["Happy"]
    end
  end
end
