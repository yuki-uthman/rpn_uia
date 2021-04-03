# frozen_string_literal: true

RSpec.describe RpnUIA::Visualizer do
  subject { described_class.new to_visualize: object }

  let(:object) { nil }

  describe "#next" do
    let(:object) { double(next: true) }

    it "calls @object.next" do
      subject.next
      expect(object).to have_received(:next)
    end
  end

  describe "#back" do
    let(:object) { double(back: true) }

    it "calls @object.back" do
      subject.back
      expect(object).to have_received(:back)
    end
  end

  describe "#visualize" do
    context "when it succeeds" do
      let(:object) do
        double(headers: %w[Input Ops Output],
               columns: [[1, 2, 3], [:+], [4]])
      end

      it "displays the state of the object in the table" do
        expected = <<~OUTPUT.rstrip
          ┌───────┬─────┬────────┐
          │ Input │ Ops │ Output │
          ├───────┼─────┼────────┤
          │   3   │     │        │
          │   2   │     │        │
          │   1   │  +  │   4    │
          └───────┴─────┴────────┘
        OUTPUT
        expect(subject.visualize).to eq expected
      end
    end
  end
end
