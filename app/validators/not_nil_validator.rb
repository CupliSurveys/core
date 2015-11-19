# Class NotNilValidator provides nil validation of value
#
class NotNilValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.nil?

    record.errors.add(
      attribute,
      options[:message] || I18n.t('errors.messages.can_not_be_nil')
    )
  end
end
