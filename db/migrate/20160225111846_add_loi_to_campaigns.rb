class AddLoiToCampaigns < ActiveRecord::Migration
  def change
    add_column :core_campaigns, :loi, :float
  end
end
