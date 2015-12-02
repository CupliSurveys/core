class AddLocaleToCampaign < ActiveRecord::Migration
  def change
    add_column :core_campaigns, :locale, :string, null: false, default: 'en'
  end
end
