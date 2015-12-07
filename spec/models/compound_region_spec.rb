require 'spec_helper'

describe Core::CompoundRegion do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to allow_value(geoname_ids: [1]).for(:settings) }
    it { is_expected.not_to allow_value(value: []).for(:settings) }
    it { is_expected.not_to allow_value({}).for(:settings) }
    it { is_expected.not_to allow_value('').for(:name) }
  end
end
