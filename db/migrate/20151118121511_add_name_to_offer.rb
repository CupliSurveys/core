class AddNameToOffer < ActiveRecord::Migration
  def change
    add_column :core_offers, :name, :string, default: '', null: false
  end
end
