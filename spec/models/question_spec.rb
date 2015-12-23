require 'spec_helper'

describe Core::Question do
  let(:key) { 'gender' }
  let(:question) { create(:question, key: key) }

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:key) }
    it { is_expected.not_to allow_value('', nil, '*', 'ключ').for(:key) }
    it { is_expected.to validate_presence_of(:kind) }
  end

  describe '#generate_key' do
    context 'when key exist' do
      it { expect(question.key).to eq(key) }
    end

    context 'when key is nil' do
      let(:key) { nil }

      it { expect(question.key).not_to eq(key) }
      it { expect(question.key.length).to be > 0 }
    end
  end

  context 'instance method' do
    describe '#redirect_object' do
      it 'references to parrent' do
        some_question = create(:question, parent_id: question.id)
        expect(some_question.redirect_object).to eq(question)
      end

      it 'references to self' do
        expect(question.redirect_object).to eq(question)
      end
    end
  end
end
