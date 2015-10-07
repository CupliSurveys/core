require 'mail'

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if valid?(value)
    record.errors.add(attribute, options[:message] || :invalid)
  end

  protected

  def valid?(value)
    return if value.blank?

    begin
      address  = Mail::Address.new(value)
      result   = address.domain && address.address == value
    rescue StandardError
      result = false
    end

    result && tld_valid?(value.split('.').last)
  end

  def tld_valid?(tld)
    return true if tld_list.empty?

    tld_list.include?(tld.downcase)
  end

  def tld_list
    @_tld_list ||= $REDIS.lrange(SyncTldListJob::TLD_LIST_NAME, 0, -1)
  end
end
