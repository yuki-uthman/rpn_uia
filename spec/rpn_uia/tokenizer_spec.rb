# frozen_string_literal: true

RSpec.describe RpnUIA::Tokenizer do
  describe ".tokens" do
    it "returns the array of tokens" do
      actual = described_class.tokenize("1 + 2 * 3")
      expect(actual).to eq [1, :+, 2, :*, 3]
    end
  end
end
