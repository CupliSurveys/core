require 'spec_helper'

describe Core::Campaign do
  describe 'validations' do
    it { expect(subject).to validate_numericality_of(:complete_price) }
    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_numericality_of(:priority) }
    it { expect(subject).to validate_inclusion_of(:priority).in_range(1..5) }
    it { expect(subject).to validate_presence_of(:user) }
  end
end
