class StandartizationOfDecimals < ActiveRecord::Migration
  def up
    change_column :core_campaigns, :complete_price, :decimal, precision: 12, scale: 2
    change_column :core_campaigns, :extra_motivation_cost, :decimal, precision: 12, scale: 2
    change_column :core_campaigns, :extra_motivation_value, :decimal, precision: 12, scale: 2

    change_column :core_quota, :complete_price, :decimal, precision: 12, scale: 2, default: 0.0, null: false
    change_column :core_quota, :ecpc, :decimal, precision: 12, scale: 2, default: 0.0, null: false
    change_column :core_quota, :extra_motivation_cost, :decimal, precision: 12, scale: 2, default: 0.0, null: false
    change_column :core_quota, :extra_motivation_value, :decimal, precision: 12, scale: 2, default: 0.0, null: false
    change_column :core_quota, :cr, :float, default: 0.0, null: false
    change_column :core_quota, :fill_rate, :float, default: 0.0, null: false
  end

  def down
    change_column :core_campaigns, :complete_price, :decimal
    change_column :core_campaigns, :extra_motivation_cost, :decimal
    change_column :core_campaigns, :extra_motivation_value, :decimal

    change_column :core_quota, :complete_price, :decimal, default: 0.0, null: false
    change_column :core_quota, :ecpc, :decimal, default: 0.0, null: false
    change_column :core_quota, :cr, :decimal, default: 0.0, null: false
    change_column :core_quota, :fill_rate, :decimal, default: 0.0, null: false
    change_column :core_quota, :extra_motivation_cost, :decimal, default: 0.0, null: false
    change_column :core_quota, :extra_motivation_value, :decimal, default: 0.0, null: false
  end
end
