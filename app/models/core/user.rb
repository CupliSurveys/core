module Core
  class User < BaseModel
    include Core::Concerns::HasApiKeys
    include Core::Concerns::Nameable
    include Core::Concerns::Roleable

    ROLES = %w[admin]

    has_many :campaigns,
      dependent: :destroy

    after_validation :change_email_uniqueness_key

    scope :customers, -> { where('campaigns_count > 0') }
    scope :search,
      -> (query) do
        query.try(:strip!)

        return unless query.present?

        where(%{
          email ILIKE :q OR
          first_name ILIKE :q OR
          last_name ILIKE :q OR
          company_name ILIKE :q
        }, q: "#{ query }%")
      end

    def resend_confirmation
      if confirmation_sent_at && confirmation_sent_at < 5.minutes.ago
        send_confirmation_instructions
      else
        errors.add(:email, :too_early_resend)
        false
      end
    end

    def change_email_uniqueness_key
      messages = errors.messages

      unless messages.include?(:email) && messages[:email].join.include?('taken')
        return
      end

      unconfirmed_taken = self.class.exists?(email: email, confirmed_at: nil)
      error_key = unconfirmed_taken ? :unconfirmed_taken : :confirmed_taken
      errors.add(:email, error_key)
    end
  end
end
