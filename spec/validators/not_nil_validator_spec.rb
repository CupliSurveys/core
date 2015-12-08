require 'spec_helper'

describe NotNilValidator do
  let(:value) { false }
  let(:object) { create(:offer) }

  before do
    NotNilValidator.new(attributes: ['']).validate_each(object, :key, value)
  end

  it { expect(object.errors[:key]).to be_empty }

  context 'when value is nil' do
    let(:value) { nil }

    it 'returns error' do
      expect(object.errors[:key]).to include("can't be null")
    end
  end

  context 'when value is empty string' do
    let(:value) { '' }

    it 'passes' do
      expect(object.errors[:key]).to be_empty
    end
  end
end
