module Core::Concerns
  # Provides cached versions of query methods for {ApiKey}.
  module ApiKeyCaches
    extend ActiveSupport::Concern

    module ClassMethods
      def cached_find_by_access_token(access_token)
        Rails.cache.fetch([:api_key, :find_by_access_token, access_token]) do
          find_by(access_token: access_token)
        end
      end
    end

    module InstanceMethods
      def cached_owner
        Rails.cache.fetch([:api_key, id, :owner]) do
          owner
        end
      end

      private

      def flush_caches
        if access_token_changed?
          Rails.cache.delete([:api_key, :find_by_access_token, access_token_was])
        end

        Rails.cache.delete([:api_key, :find_by_access_token, access_token])
        Rails.cache.delete([:api_key, id, :owner])
      end
    end

    included do
      extend ClassMethods
      include InstanceMethods

      after_save :flush_caches
      after_destroy :flush_caches
    end
  end
end
