# frozen_string_literal: true

RSpec.describe RpnUIA::Table, "#max_column" do
  let(:table) { described_class.new columns: columns }

  context "when @columns are nil" do
    let(:columns) { nil }

    it "returns nil" do
      expect(table.max_column).to be_nil
    end
  end

  context "when @columns are given" do
    let(:columns) { [[1, 2, 3], [1, 2, 3, 4, 5]] }

    it "returns the longest column" do
      expect(table.max_column).to eq [1, 2, 3, 4, 5]
    end
  end
end
