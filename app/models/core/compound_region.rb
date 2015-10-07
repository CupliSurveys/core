module Core
  # Define compound region model. It may be composed of cities, regions and
  #   countries
  #
  # @see City City model
  # @see Region Region model
  # @see Country Country model
  #
  # @!attribute [rw] name
  #   @return [String] Name of the compound region
  # @!attribute [rw] settings
  #   Options:
  #     - **:city_id** (*Array<Integer>*) City ids
  #     - **:region_id** (*Array<Integer>*) Region ids
  #     - **:country_id** (*Array<Integer>*) Country ids
  #   @return [Hash] Location ids
  class CompoundRegion < ActiveRecord::Base
    has_paper_trail only: %i(name settings)

    validates :name, presence: true
    validates :settings, compound_region_settings: true
  end
end
