class ChageOffersLocale < ActiveRecord::Migration
  def up
    change_column :core_offers, :locale, :string, default: '', null: false
  end

  def down
    change_column :core_offers, :locale, :string, default: :en, null: false
  end
end
