# frozen_string_literal: true

require_relative "trace_spec_helper"

RSpec.describe RpnUIA::Traceable, "#save_all" do
  subject { Cat.new }

  it "saves all of what is being traced" do
    subject.state = "Running"
    subject.feeling = "Happy"
    subject.save_all

    expect(subject.state_trace).to eq ["Running"]
    expect(subject.feeling_trace).to eq ["Happy"]
  end
end
