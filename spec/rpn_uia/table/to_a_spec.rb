# frozen_string_literal: true

RSpec.describe RpnUIA::Table, "#to_a" do
  subject { table.to_a }

  let(:table) { described_class.new headers: headers, columns: columns }
  let(:headers) { %w[header1 header2] }
  let(:columns) { [[1, 2, 3], [4, 5, 6]] }

  it { is_expected.to be_instance_of(Array) }

  context "with both headers and columns" do
    it "returns headers and columns" do
      expect(table.to_a).to eq [headers, columns]
    end
  end

  context "with no headers" do
    let(:headers) { nil }

    it "returns just columns" do
      expect(table.to_a).to eq [[nil], columns]
    end
  end

  context "with no columns" do
    let(:columns) { nil }

    it "returns just headers" do
      expect(table.to_a).to eq [headers, [nil]]
    end
  end

  context "with empty table" do
    let(:headers) { nil }
    let(:columns) { nil }

    it "returns nil" do
      expect(table.to_a).to eq nil
    end
  end
end
