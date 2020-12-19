# frozen_string_literal: true

RSpec.describe MonsterMessages do
  describe '.valid_message_count' do
    subject { described_class.valid_message_count(input) }
    context 'when example is given' do
      let(:input) { read_file('day19/example') }
      it { is_expected.to eq(2) }
    end

    context 'when input is given' do
      let(:input) { read_file('day19/input') }
      it { is_expected.to eq(248) }
    end
  end
end
