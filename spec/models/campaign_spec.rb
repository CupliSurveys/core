require 'spec_helper'

describe Core::Campaign do
  describe 'validations' do
    it { is_expected.to validate_numericality_of(:complete_price) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_numericality_of(:priority) }
    it { is_expected.to validate_inclusion_of(:priority).in_range(1..5) }
    it { is_expected.to validate_presence_of(:user) }

    it { is_expected.to have_many(:quota).dependent(:destroy) }
    it { is_expected.to have_many(:questions) }
    it { is_expected.to have_many(:substitutions).dependent(:destroy) }
    it { is_expected.to have_many(:campaign_questions).dependent(:destroy) }
    it { is_expected.to have_many(:substitution_questions) }
  end
end
