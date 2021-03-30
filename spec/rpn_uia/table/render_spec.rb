# frozen_string_literal: true

RSpec.describe RpnUIA::Table, "#render" do
  let(:table) { described_class.new headers: headers, columns: columns }
  let(:headers) { %w[Stack] }
  let(:columns) { [[1, 2, 3]] }

  context "without options" do
    let(:headers) { nil }

    it "renders with a default style" do
      expected = <<~OUTPUT.rstrip
        ┌───┐
        │ 3 │
        │ 2 │
        │ 1 │
        └───┘
      OUTPUT
      expect(table.render).to eq expected
    end
  end

  context "with headers" do
    it "renders with a header" do
      expected = <<~OUTPUT.rstrip
        ┌───────┐
        │ Stack │
        ├───────┤
        │   3   │
        │   2   │
        │   1   │
        └───────┘
      OUTPUT
      expect(table.render).to eq expected
    end
  end

  context "with specific height" do
    it "adds empty rows as needed" do
      table.height = 4
      output = <<~OUTPUT.rstrip
        ┌───────┐
        │ Stack │
        ├───────┤
        │       │
        │   3   │
        │   2   │
        │   1   │
        └───────┘
      OUTPUT
      expect(table.render).to eq output
    end
  end

  context "with custom options" do
    it "applies alignment" do
      expected = <<~OUTPUT.rstrip
        ┌───────┐
        │ Stack │
        ├───────┤
        │ 3     │
        │ 2     │
        │ 1     │
        └───────┘
      OUTPUT
      options = { alignment: [:left] }
      expect(table.render(options)).to eq expected
    end

    it "applies padding" do
      expected = <<~OUTPUT.rstrip
        ┌─────┐
        │Stack│
        ├─────┤
        │  3  │
        │  2  │
        │  1  │
        └─────┘
      OUTPUT
      options = { padding: [0, 0, 0, 0] }
      expect(table.render(options)).to eq expected
    end
  end

  context "when there are many columns" do
    let(:columns) { [[3, 8, 1, 5, 6], ["+", "*"], [30]] }
    let(:headers) { %w[Infix Ops Output] }

    it "renders columns side by side" do
      expected = <<~OUTPUT.rstrip
        ┌───────┬─────┬────────┐
        │ Infix │ Ops │ Output │
        ├───────┼─────┼────────┤
        │   6   │     │        │
        │   5   │     │        │
        │   1   │     │        │
        │   8   │  *  │        │
        │   3   │  +  │   30   │
        └───────┴─────┴────────┘
      OUTPUT
      expect(table.render).to eq expected
    end

    it "can render columns with an extra height" do
      table.height = 6
      expected = <<~OUTPUT.rstrip
        ┌───────┬─────┬────────┐
        │ Infix │ Ops │ Output │
        ├───────┼─────┼────────┤
        │       │     │        │
        │   6   │     │        │
        │   5   │     │        │
        │   1   │     │        │
        │   8   │  *  │        │
        │   3   │  +  │   30   │
        └───────┴─────┴────────┘
      OUTPUT
      expect(table.render).to eq expected
    end
  end
end
