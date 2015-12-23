module Core::Concerns
  # This module implements the functionality of roles
  module Nameable
    extend ActiveSupport::Concern

    included do
      before_validation :strip_name_fields
    end

    def full_name
      [first_name, last_name].reject(&:blank?).join(' ')
    end

    def name
      full_name.presence || email
    end

    def full_name=(string)
      list = (string || '').squish.split
      self.first_name = list.shift
      self.last_name = list.pop
    end

    private

    def strip_name_fields
      %w(first_name last_name).each do |field|
        send(field).strip! if send(field)
      end
    end
  end
end
