class AddCrToCoreOffers < ActiveRecord::Migration
  def change
    add_column :core_offers, :cr, :float, default: 0.0, null: false
  end
end
