# frozen_string_literal: true

RSpec.shared_examples "a table" do
  subject { described_class.new }

  describe "#headers" do
    it "returns arrays of titles for each data" do
      expect(subject).to respond_to(:headers)
      expect(subject.headers).to be_an_instance_of Array
    end
  end

  describe "#columns" do
    it "returns arrays of data" do
      expect(subject).to respond_to(:columns)
      expect(subject.columns).to be_an_instance_of Array
    end
  end

  it "has the same number of elements #headers & #columns" do
    expect(subject.headers.size).to eq subject.columns.size
  end
end
