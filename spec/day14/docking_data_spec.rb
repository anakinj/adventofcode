# frozen_string_literal: true

RSpec.describe DockingData do
  describe '.execute' do
    subject { described_class.execute(input) }
    context 'when example is given' do
      let(:input) { read_file('day14/example') }
      it { is_expected.to eq(165) }
    end
    context 'when input is given' do
      let(:input) { read_file('day14/input') }
      it { is_expected.to eq(10_050_490_168_421) }
    end
  end

  describe '.execute_v2' do
    subject { described_class.execute_v2(input) }
    context 'when example is given' do
      let(:input) { read_file('day14/example2') }
      it { is_expected.to eq(208) }
    end
    context 'when input is given' do
      let(:input) { read_file('day14/input') }
      it { is_expected.to eq(2_173_858_456_958) }
    end
  end
end
