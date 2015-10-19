class SettingsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    valid = true
    valid &&= !value.values.map { |i| satisfies_each?(i) }.include?(false)
    valid &&= !value.keys.map { |i| satisfies_each?(i) }.include?(false)

    return if valid

    record.errors.add(attribute, options[:message] || :invalid)
  end

  def satisfies_each?(element)
    return true if element.is_a?(FalseClass)
    return true if element.is_a?(Hash)
    return true if element.is_a?(Array)
    element.present?
  end
end
