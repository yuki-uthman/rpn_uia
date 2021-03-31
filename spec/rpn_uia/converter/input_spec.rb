# frozen_string_literal: true

RSpec.describe RpnUIA::Converter, "#input=" do
  let(:conv) { described_class.new }

  it "clears the other arrays" do
    conv.input = []
    expect(conv.input).to eq []
    expect(conv.output).to eq []
    expect(conv.ops).to eq []
  end

  context "with Array" do
    let(:input) { [1, 2, 3] }

    it "sets the input as it is" do
      conv.input = [1, 2, 3]
      expect(conv.input).to eq [1, 2, 3]
    end
  end

  context "with String" do
    let(:input) { "1 + 2 * 3" }

    it "tokenizes into array" do
      conv.input = "1 + 2 * 3"
      expect(conv.input).to eq [1, :+, 2, :*, 3]
    end
  end
end
