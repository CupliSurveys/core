class AddReversedToCoreQuota < ActiveRecord::Migration
  def change
    add_column :core_quota, :reversed, :boolean, null: false, default: false
  end
end
