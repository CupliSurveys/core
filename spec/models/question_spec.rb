require 'spec_helper'

describe Core::Question do
  describe 'validations' do
    it { expect(subject).to validate_uniqueness_of(:key) }
    it { expect(subject).not_to allow_value('', nil, '*', 'ключ').for(:key) }
    it { expect(subject).to validate_presence_of(:kind) }
  end
end
