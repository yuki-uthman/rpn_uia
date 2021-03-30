# frozen_string_literal: true

RSpec.describe RpnUIA::Table, "#new" do
  let(:headers) { %w[header1 header2] }
  let(:columns) { [[1, 2, 3], [4, 5, 6]] }

  context "when initalized with no args" do
    it {
      expect(subject).to have_attributes(headers: nil,
                                         columns: nil,
                                         height: 0)
    }
  end

  context "when initalized with headers" do
    subject { described_class.new headers: headers }

    it {
      expect(subject).to have_attributes(headers: headers,
                                         columns: nil,
                                         height: 0)
    }
  end

  context "when initalized with columns" do
    subject { described_class.new columns: columns }

    it {
      expect(subject).to have_attributes(headers: nil,
                                         columns: columns,
                                         height: 3)
    }
  end

  context "when initalized with headers and columns" do
    subject { described_class.new headers: headers, columns: columns }

    it {
      expect(subject).to have_attributes(headers: headers,
                                         columns: columns,
                                         height: 3)
    }
  end
end
