require 'spec_helper'

describe Core::Offer do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:provider) }
    it { is_expected.to validate_presence_of(:cost_model) }
    it { is_expected.to validate_presence_of(:price) }

    it { is_expected.to allow_value(foo: :bar).for(:settings) }
    it { is_expected.to allow_value(foo: true).for(:settings) }
    it { is_expected.to allow_value(foo: false).for(:settings) }
    it { is_expected.to allow_value(foo: []).for(:settings) }
    it { is_expected.to allow_value(foo: {}).for(:settings) }
    it { is_expected.to allow_value(foo: false, baz: :bar).for(:settings) }

    it { is_expected.not_to allow_value('' => :foo).for(:settings) }
    it { is_expected.not_to allow_value(foo: '').for(:settings) }
    it { is_expected.not_to allow_value(foo: nil, bar: true).for(:settings) }

    it 'validate inclusion cost_model into set of valid values' do
      is_expected.
        to validate_inclusion_of(:cost_model).in_array(%w(cpp cpa cpm cpc))
    end

    it 'validate values range of price' do
      is_expected.
        to validate_numericality_of(:price).is_greater_than_or_equal_to(0)
    end
  end

  context 'instance methods' do
    subject { create(:offer, attributes) }

    describe '#normalize_data' do
      describe 'normalizes locale' do
        let(:attributes) { { locale: locale } }

        context 'when uppercased locale' do
          let(:locale) { :RU }

          it { expect(subject.locale).to eq(locale.to_s.downcase) }
        end
      end
    end
  end
end
