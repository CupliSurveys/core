# Class CompoundRegionSettingsValidator provides validation of {CompoundRegion}
#   settings
#
class CompoundRegionSettingsValidator < ActiveModel::EachValidator
  ALLOWED_KEYS = %i(geoname_ids)

  def validate_each(record, attribute, value)
    return if value.present? && correct_data_format?(value)

    record.errors.add(attribute, options[:message] || :invalid)
  end

  protected

  # Checks inclusion of allowed keys.
  #
  # @param [Hash] value Checking value
  #
  # @return [Boolean] true if value contains only allowed keys, otherwise false
  #
  def only_allowed_keys?(value)
    val = value.symbolize_keys
    val.slice(*ALLOWED_KEYS).present? && val.except(*ALLOWED_KEYS).blank?
  end

  # Checks validity of keys and correctness of values.
  #
  # @param [Hash] value Checking value
  #
  # @return [Boolean] true if value contains correct structure of data,
  #   otherwise false
  #
  def correct_data_format?(value)
    return false unless only_allowed_keys?(value)

    value.any? do |_key, val|
      val.present? && val.is_a?(Array) && val.all? { |el| el.is_a?(Numeric) }
    end
  end
end
