# frozen_string_literal: true

RSpec.describe ShuttleSearch do
  describe '.earliest' do
    subject { described_class.earliest(input) }
    context 'when example is given' do
      let(:input) { read_file('day13/example1') }
      it { is_expected.to eq(295) }
    end
    context 'when input is given' do
      let(:input) { read_file('day13/input') }
      it { is_expected.to eq(246) }
    end
  end
end
