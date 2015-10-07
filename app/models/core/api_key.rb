module Core
  class ApiKey < ActiveRecord::Base
    include Core::Concerns::ApiKeyCaches

    belongs_to :owner, polymorphic: true

    validates :access_token,
      presence: true,
      uniqueness: true

    validates :owner,
      presence: true

    after_initialize :generate_access_token, unless: :access_token

    private

    def generate_access_token
      loop do
        self.access_token = SecureRandom.hex
        break unless self.class.exists?(access_token: access_token)
      end
    end
  end
end
