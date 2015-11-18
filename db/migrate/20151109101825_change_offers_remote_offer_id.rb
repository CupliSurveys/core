class ChangeOffersRemoteOfferId < ActiveRecord::Migration
  def up
    change_column :core_offers, :remote_offer_id, :string, default: '', null: false
  end

  def down
    change_column :core_offers, :remote_offer_id, :integer, default: '', null: false
  end
end
