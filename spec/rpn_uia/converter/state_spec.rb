# frozen_string_literal: true

RSpec.describe RpnUIA::Converter, "#state" do
  let(:conv) { described_class.new }

  it "returns current state" do
    expect(conv.state).to eq [[], [], []]
  end

  it "updates its state" do
    new_state = [[1, 2, 3], [4], [:*]]
    conv.state = new_state
    expect(conv.state).to eq new_state
  end
end
