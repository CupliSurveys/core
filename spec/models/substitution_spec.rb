require 'spec_helper'

describe Core::Substitution do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:campaign) }
    it { is_expected.to validate_presence_of(:question) }
  end
end
