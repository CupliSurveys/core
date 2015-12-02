class AddMarketingInfoToCampaign < ActiveRecord::Migration
  def change
    add_column :core_campaigns, :marketing_loi, :string, null: false, default: ''
    add_column :core_campaigns, :marketing_title, :string, null: false, default: ''
    add_column :core_campaigns, :marketing_description, :string, null: false, default: ''
  end
end
