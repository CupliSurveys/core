# Class UserConfirmationPeriodValidator provides validation of confirmation
#   period for {User} account
#
class UserConfirmationPeriodValidator < ActiveModel::EachValidator
  def validate_each(record, _attribute, value)
    return if !value.persisted? || value.confirmed?
    return if value.try(:send, :confirmation_period_valid?)

    record.errors.add(
      :base,
      options[:message] || I18n.t('errors.messages.expired')
    )
  end
end
