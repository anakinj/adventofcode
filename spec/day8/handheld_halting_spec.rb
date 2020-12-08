# frozen_string_literal: true

RSpec.describe HandheldHalting do
  let(:bootloader) { HandheldHalting::Bootloader.new(input) }
  context 'when example is given' do
    let(:input) { read_file('day8/example') }
    it 'counts to 5' do
      expect(bootloader.execute).to eq(5)
    end
  end
  context 'when actual data is given' do
    let(:input) { read_file('day8/input') }
    it 'counts to 1594' do
      expect(bootloader.execute).to eq(1594)
    end
  end
end
