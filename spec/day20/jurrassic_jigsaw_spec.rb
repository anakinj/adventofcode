# frozen_string_literal: true

RSpec.describe JurassicJigsaw do
  describe '.multiply_corners' do
    subject { described_class.multiply_corners(input) }
    context 'when example is given' do
      let(:input) { read_file('day20/example') }
      it { is_expected.to eq(20_899_048_083_289) }
    end

    context 'when input is given' do
      let(:input) { read_file('day20/input') }
      it { is_expected.to eq(104_831_106_565_027) }
    end
  end

  describe '.seamonster' do
    subject { described_class.seamonster(input) }
    context 'when example is given' do
      let(:input) { read_file('day20/example') }
      it { is_expected.to eq(273) }
    end

    context 'when input is given' do
      let(:input) { read_file('day20/input') }
      it { is_expected.to eq(104_831_106_565_027) }
    end
  end
end
