# frozen_string_literal: true

require_relative "trace_spec_helper"

RSpec.describe RpnUIA::Traceable, "#traces" do
  subject { Cat.new }

  it "keeps record of what is being traced" do
    expect(subject.traces).to eq [:state, :feeling]
  end
end
