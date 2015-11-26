class AddRemoteCampaignIdToCampaigns < ActiveRecord::Migration
  def change
    add_column :core_campaigns, :remote_campaign_id, :string, null: false, default: ''
  end
end
