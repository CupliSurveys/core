require 'spec_helper'

describe Core::Provider do
  describe 'validations' do
    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_presence_of(:slug) }
  end
end
