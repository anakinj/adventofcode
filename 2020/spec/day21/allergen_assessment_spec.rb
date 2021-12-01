# frozen_string_literal: true

RSpec.describe AllergenAssessment do
  describe '.count_ingredients' do
    subject { described_class.count_ingredients(input) }
    context 'when example is given' do
      let(:input) { read_file('day21/example') }
      it { is_expected.to eq(5) }
    end

    context 'when input is given' do
      let(:input) { read_file('day21/input') }
      it { is_expected.to eq(2302) }
    end
  end

  describe '.dangerous_ingredients' do
    subject { described_class.dangerous_ingredients(input) }
    context 'when example is given' do
      let(:input) { read_file('day21/example') }
      it { is_expected.to eq('mxmxvkd,sqjhc,fvjkl') }
    end

    context 'when input is given' do
      let(:input) { read_file('day21/input') }
      it { is_expected.to eq('smfz,vhkj,qzlmr,tvdvzd,lcb,lrqqqsg,dfzqlk,shp') }
    end
  end
end
