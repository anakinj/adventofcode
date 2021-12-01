# frozen_string_literal: true

RSpec.describe RainRisk do
  describe '.manhattan_position_for Ship' do
    subject { described_class.manhattan_position_for(described_class::Ship, input) }
    context 'when example is given' do
      let(:input) { read_file('day12/example1') }
      it { is_expected.to eq(25) }
    end
    context 'when input is given' do
      let(:input) { read_file('day12/input') }
      it { is_expected.to eq(1441) }
    end
  end

  describe '.manhattan_position_for WaypointShip' do
    subject { described_class.manhattan_position_for(described_class::WaypointShip, input) }
    context 'when example is given' do
      let(:input) { read_file('day12/example1') }
      it { is_expected.to eq(286) }
    end
    context 'when input is given' do
      let(:input) { read_file('day12/input') }
      it { is_expected.to eq(61_616) }
    end
  end
end
