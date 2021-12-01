# frozen_string_literal: true

RSpec.describe TicketTranslation do
  describe '.error_rate' do
    subject { described_class.new(input).error_rate }
    context 'when example is given' do
      let(:input) { read_file('day16/example') }
      it { is_expected.to eq(71) }
    end
    context 'when input is given' do
      let(:input) { read_file('day16/input') }
      it { is_expected.to eq(26_053) }
    end
  end

  describe '.error_rate' do
    subject { described_class.new(input).fields_multiplied }
    context 'when example is given' do
      subject { described_class.new(input).fields_multiplied(/s/) }
      let(:input) { read_file('day16/example2') }
      it { is_expected.to eq(12 * 13) }
    end
    context 'when input is given' do
      let(:input) { read_file('day16/input') }
      it { is_expected.to eq(1_515_506_256_421) }
    end
  end
end
