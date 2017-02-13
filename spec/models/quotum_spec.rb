require 'spec_helper'

describe Core::Quotum do
  let!(:collector) { create(:question, :collector) }
  describe 'validations' do
    it { is_expected.to validate_presence_of(:campaign) }
    let(:settings) { {} }
    let(:quotum) { build(:quotum, question: question, settings: settings) }

    describe 'with collector question' do
      let(:question) { find_or_create(:question, key: :collector) }

      it 'is valid' do
        subject = build(:quotum, question: question, settings: settings)
        expect(subject).to be_valid
      end
    end

    describe 'with regular question' do
      let(:question) { create(:question, settings: {}) }

      it 'is invalid' do
        is_expected.not_to be_valid
      end
    end

    describe 'with empty value' do
      let(:settings) { { value: [] } }
      let(:question) { create(:question, settings: {}) }

      it 'is invalid' do
        is_expected.not_to be_valid
      end
    end
  end

  describe 'scopes' do
    describe '#roots' do
      let(:campaign) { create(:campaign) }
      let(:non_roots) { create_list(:quotum, 10, parent_ids: roots.map(&:id)) }

      it 'returns root quota' do
        expect(campaign.quota.roots.map{|i| i.question.key}).to include('collector')
      end
    end

    describe '#with_setting' do
      let(:quotum) { create(:quotum, settings: { value: [1], type: 'age' }) }
      before { create_list(:quotum, 5) }

      it do
        expect(Core::Quotum.with_setting(:type, 'age')).to eq([quotum])
      end
    end
  end

  describe 'instance methods' do
    describe '#children' do
      let(:subject) { create(:quotum) }
      let(:children) { create_list(:quotum, 3, parent_ids: [subject.id]) }

      it 'returns children quota' do
        expect(subject.children).to eq(children)
      end
    end

    describe '#parents' do
      let(:parents) { create_list(:quotum, 2) }
      let(:subject) { create(:quotum, parent_ids: parents.map(&:id)) }

      it 'returns parents quota' do
        expect(subject.parents).to eq(parents)
      end
    end
  end
end
