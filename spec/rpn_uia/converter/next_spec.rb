# frozen_string_literal: true

RSpec.describe RpnUIA::Converter, "#next" do
  let(:conv) { described_class.new }

  context "when @input and @ops becomes empty" do
    it "returns false" do
      conv.input = [1]
      conv.next
      expect(conv.next).to eq false
    end
  end

  context "when either @input or @ops is not empty" do
    it "returns true" do
      conv.input = [1]
      expect(conv.next).to eq true
    end
  end

  context "when the @input.last is a number" do
    before do
      conv.input = [1, 2]
      conv.next
    end

    it "pops the number" do
      expect(conv.input).to eq [1]
    end

    it "pushes to @output" do
      expect(conv.output).to eq [2]
    end
  end

  context "when the @input.last is an operator" do
    before do
      conv.input = [:*]
      conv.next
    end

    context "when @ops is empty" do
      it "pops the @input" do
        expect(conv.input).to eq []
      end

      it "pushes to @ops" do
        expect(conv.ops).to eq [:*]
      end
    end

    context "with stronger precedence than what is in @ops" do
      before do
        conv.state = [[:*], [:+], []]
        conv.next
      end

      it "pops the @input" do
        expect(conv.input).to eq []
      end

      it "pushes to @ops" do
        expect(conv.ops).to eq [:+, :*]
      end
    end

    context "with same/weaker precedence than what is in @ops" do
      before do
        conv.state = [[:+], [:*, :/], []]
        conv.next
      end

      it "does not pop @input" do
        expect(conv.input).to eq [:+]
      end

      it "pops @ops" do
        expect(conv.ops).to eq [:*]
      end

      it "pushes to @output" do
        expect(conv.output).to eq [:/]
      end

      it "supports subsequent #next" do
        conv.next
        expect(conv.state).to eq [[:+], [], [:/, :*]]
      end
    end
  end

  context "when only @ops are left" do
    before do
      conv.state = [[], [:+, :*], []]
      conv.next
    end

    it "pops @ops" do
      expect(conv.ops).to eq [:+]
    end

    it "pushes to @ouput" do
      expect(conv.output).to eq [:*]
    end

    it "supports subsequent #next" do
      conv.next
      expect(conv.state).to eq [[], [], [:*, :+]]
    end
  end

  context "when used with while loop" do
    it "pushes all the numbers to @output" do
      conv.input = [1, 2, 3]
      conv.next while conv.next
      expect(conv.state).to eq [[], [], [3, 2, 1]]
    end

    it "pushes all the operators to @output" do
      conv.input = [:+, :*, :^]
      conv.next while conv.next
      expect(conv.state).to eq [[], [], [:^, :*, :+]]
    end

    it "pushes the mixtures to @output in the correct order" do
      conv.input = [3, :*, 2, :+, 1]
      conv.next while conv.next
      expect(conv.output).to eq [1, 2, 3, :*, :+]

      conv.input = [5, :-, 4, :/, 3, :*, 2, :+, 1]
      conv.next while conv.next
      expected = [1, 2, 3, :*, 4, :/, :+, 5, :-]
      expect(conv.output).to eq expected
    end
  end
end
