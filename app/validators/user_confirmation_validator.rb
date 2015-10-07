# Class UserConfirmationValidator provides confirmation validation of {User}
#   account
#
class UserConfirmationValidator < ActiveModel::EachValidator
  def validate_each(record, _attribute, value)
    return unless value.persisted?
    return if value.confirmed?

    record.errors.add(
      :email,
      options[:message] || I18n.t('devise.failure.unconfirmed_taken')
    )
  end
end
