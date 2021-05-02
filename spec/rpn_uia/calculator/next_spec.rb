# frozen_string_literal: true

RSpec.describe RpnUIA::Calculator, "#next" do
  before do
    subject.input = [:+, :*, 3, 8, 4].reverse
  end

  context "when @input becomes empty" do
    it "returns false" do
      subject.next
      subject.next
      subject.next
      subject.next
      subject.next
      subject.next
      subject.next
      expect(subject.next).to eq false
    end
  end

  context "when @input.last is a number" do
    it "pops the element and pushes it onto the numbers" do
      subject.next
      expect(subject.state).to eq [[:+, :*, 3, 8], [4], []]

      subject.next
      expect(subject.state).to eq [[:+, :*, 3], [4, 8], []]

      subject.next
      expect(subject.state).to eq [[:+, :*], [4, 8, 3], []]
    end
  end

  context "when @input.last is an operator" do
    before do
      subject.state = [[:+, :*], [4, 8, 3], []]
    end

    it "pops 2 numbers" do
      subject.next
      expect(subject.numbers).to eq [4]
    end

    it "pops the operator from the input" do
      subject.next
      expect(subject.input).to eq [:+]
    end

    it "pushes the correct expression onto @expression" do
      subject.next
      expect(subject.expression).to eq ["8 * 3 = 24"]
    end
  end

  context "when there is @result" do
    before do
      subject.state = [[:+, :*], [4, 8, 3], []]
      subject.next
    end

    it "pushes the result to @numbers" do
      subject.next
      expect(subject.state).to eq [[:+], [4, 24], ["8 * 3 = 24"]]

      subject.next
      expect(subject.state).to eq [[], [], ["8 * 3 = 24", "4 + 24 = 28"]]
      expect(subject.result).to eq 28

      subject.next
      expect(subject.state).to eq [[], [28], ["8 * 3 = 24", "4 + 24 = 28"]]
    end
  end

  context "when used with while loop" do
    it "stops at the final result" do
      subject.next while subject.next
      expect(subject.state).to eq [[], [28], ["8 * 3 = 24", "4 + 24 = 28"]]
    end
  end
end
