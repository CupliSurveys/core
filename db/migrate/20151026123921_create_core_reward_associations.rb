class CreateCoreRewardAssociations < ActiveRecord::Migration
  def change
    create_table :core_reward_associations do |t|
      t.integer :reward_id, index: true
      t.integer :rewardable_id, index: true
      t.string :rewardable_type, index: true

      t.timestamps null: false
    end
  end
end
