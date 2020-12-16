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
end
