# frozen_string_literal: true

RSpec.describe RpnUIA::Table, "#columns=" do
  let(:table) { described_class.new columns: columns }
  let(:columns) { [[1, 2, 3], [1, 2, 3, 4, 5]] }

  # the table is not meant to shrink
  context "when new columns are shorter than the current" do
    it "keeps the current height" do
      table.columns = [[1, 2, 3], [1, 2, 3]]
      expect(table.height).to eq 5
    end
  end

  context "when new columns are taller" do
    it "expands the height" do
      table.columns = [[1, 2, 3], [1, 2, 3, 4, 5, 6]]
      expect(table.height).to eq 6
    end
  end
end
