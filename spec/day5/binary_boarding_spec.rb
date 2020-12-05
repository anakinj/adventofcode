# frozen_string_literal: true

RSpec.describe BinaryBoarding do
  let(:input) { File.read(File.join(__dir__, 'input1')) }

  context 'when example boardingpasses given' do
    it 'figures out row 44, seat 5 and id 357' do
      expect(described_class.process_boarding_pass('FBFBBFFRLR')).to eq([44, 5, 357])
    end

    it 'figures out row 44, seat 5 and id 357' do
      expect(described_class.process_boarding_pass('BFFFBBFRRR')).to eq([70, 7, 567])
    end

    it 'figures out row 44, seat 5 and id 357' do
      expect(described_class.process_boarding_pass('FFFBBBFRRR')).to eq([14, 7, 119])
    end

    it 'figures out row 44, seat 5 and id 357' do
      expect(described_class.process_boarding_pass('BBFFBBFRLL')).to eq([102, 4, 820])
    end
  end

  context 'when big set is given' do
    it 'figures out the biggest seat id' do
      expect(described_class.max_seat_id(input)).to eq(908)
    end

    it 'finds my seat' do
      expect(described_class.find_missing_seat(input)).to eq(619)
    end
  end

end
