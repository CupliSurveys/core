module Core
  # == Schema Information
  #
  # Table name: providers
  #
  #  id         :integer          not null, primary key
  #  name       :string(255)
  #  utm_hash   :string(255)
  #  slug       :string(255)
  #  created_at :datetime         not null
  #  updated_at :datetime         not null
  #
  # Indexes
  #
  #  index_providers_on_slug  (slug)
  #

  class Provider < ActiveRecord::Base
    has_many :offers

    validates :name, presence: true
    validates :slug, presence: true
  end
end
