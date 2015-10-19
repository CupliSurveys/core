module Core::Concerns
  module HasApiKeys
    extend ActiveSupport::Concern

    included do
      has_many :api_keys,
        as: :owner,
        dependent: :destroy

      after_save :flush_api_keys_caches
    end

    private

    def flush_api_keys_caches
      api_key_ids.each do |api_key_id|
        Rails.cache.delete([:api_key, api_key_id, :owner])
      end
    end
  end
end
