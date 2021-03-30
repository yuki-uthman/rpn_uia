# frozen_string_literal: true

RSpec.describe RpnUIA::Table, "#height" do
  let(:table) {
    described_class.new columns: columns
  }
  let(:columns) { [%w[1 2 3], %w[1 2 3 4 5]] }

  context "when height is not set explicitly" do
    it "returns the maximum length of columns" do
      expect(table.height).to eq 5
    end
  end

  context "when height is less than the column length" do
    it "returns the column length" do
      table.height = 3
      expect(table.height).to eq 5
    end
  end

  context "when height is more than the column length" do
    it "returns the height" do
      table.height = 10
      expect(table.height).to eq 10
    end
  end
end
