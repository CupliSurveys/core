describe Core::ApiKey do
  describe 'associations' do
    it { expect(subject).to belong_to(:owner) }
  end

  describe 'validations' do
    let(:subject) { build(:api_key, owner: build(:admin_user)) }

    it { expect(subject).to validate_uniqueness_of(:access_token) }
    it { expect(subject).to validate_presence_of(:access_token) }
    it { expect(subject).to validate_presence_of(:owner) }
  end

  describe 'access token generation' do
    it 'generates HEX string' do
      expect(subject.access_token).to match(/\A[0-9a-f]{32}\Z/)
    end
  end
end
