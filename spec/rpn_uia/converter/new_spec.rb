# frozen_string_literal: true

RSpec.describe RpnUIA::Converter, "#new" do
  subject { described_class.new }

  it { is_expected.to have_attributes(input: []) }
  it { is_expected.to have_attributes(output: []) }
  it { is_expected.to have_attributes(ops: []) }
  it { is_expected.to have_attributes(history: []) }
end
