# frozen_string_literal: true

RSpec.describe RpnUIA::Converter, "#back" do
  let(:conv) { described_class.new }

  context "when no previous states" do
    before do
      conv.input = [1, 2, 3]
    end

    it "keeps the same state" do
      conv.back
      expected = [[1, 2, 3], [], []]
      expect(conv.state).to eq expected
    end

    it "returns false" do
      expect(conv.back).to eq false
    end
  end

  context "when there is a previous states" do
    before do
      conv.input = [1, 2, 3]
      conv.next
    end

    it "restores the previous state" do
      expect(conv.state).to eq [[1, 2], [], [3]]
      conv.back
      expect(conv.state).to eq [[1, 2, 3], [], []]
    end

    it "returns true" do
      expect(conv.back).to eq true
    end
  end

  context "when used with while loop" do
    it "goes back to the beginning" do
      conv.input = [1, 2, 3]
      conv.next while conv.next
      expect(conv.state).to eq [[], [], [3, 2, 1]]

      conv.back while conv.back
      expect(conv.state).to eq [[1, 2, 3], [], []]
    end
  end
end
