class RemoveCampaignFromOffers < ActiveRecord::Migration
  def up
    remove_column :core_offers, :campaign_id
  end
end

