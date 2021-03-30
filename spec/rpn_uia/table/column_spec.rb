# frozen_string_literal: true

RSpec.describe RpnUIA::Table, "#column" do
  let(:headers) { %w[header1 header2] }
  let(:column1) { %w[1 2 3] }
  let(:column2) { %w[4 5 6] }
  let(:columns) { [column1, column2] }
  let(:table) {
    described_class.new headers: headers, columns: columns
  }

  context "with String" do
    it "returns column with a header name" do
      expect(table.column("header1")).to eq column1
      expect(table.column("header2")).to eq column2
    end
  end

  context "with Symbol" do
    it "returns column with a header name" do
      expect(table.column(:header1)).to eq column1
      expect(table.column(:header2)).to eq column2
    end
  end

  context "with Integer" do
    it "returns column with an index" do
      expect(table.column(0)).to eq column1
      expect(table.column(1)).to eq column2
    end
  end

  context "with non-existent header name or an index" do
    it "returns nil" do
      expect(table.column("header3")).to eq nil
      expect(table.column(3)).to eq nil
    end
  end
end
