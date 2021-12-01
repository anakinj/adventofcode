# frozen_string_literal: true

RSpec.describe RambunctiousRecitation do
  describe '.speak_until' do
    subject { described_class.new(input).speak_until }
    context 'when example is given' do
      let(:input) { read_file('day15/example') }
      it { is_expected.to eq(436) }
    end
    context 'when input is given' do
      let(:input) { read_file('day15/input') }
      it { is_expected.to eq(929) }
    end
  end

  describe '.speak_until (bigger)' do
    subject { described_class.new(input).speak_until(turns: 30_000_000) }
    context 'when example is given' do
      let(:input) { read_file('day15/example') }
      it { is_expected.to eq(175_594) }
    end
    context 'when input is given' do
      let(:input) { read_file('day15/input') }
      it { is_expected.to eq(16_671_510) }
    end
  end
end
