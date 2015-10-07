module Core::Concerns
  # This module implements the functionality of roles
  module Roleable
    extend ActiveSupport::Concern

    def roles=(roles)
      return if roles.empty?

      self.roles_mask =
        (roles & available_roles).map { |r| 2**available_roles.index(r) }.sum
    end

    def roles
      available_roles.reject do |r|
        ((roles_mask || 0) & 2**available_roles.index(r)).zero?
      end
    end

    def is?(role)
      roles.include?(role.to_s)
    end

    def available_roles
      self.class::ROLES
    end
  end
end
