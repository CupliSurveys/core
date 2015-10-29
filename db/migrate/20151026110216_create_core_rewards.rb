class CreateCoreRewards < ActiveRecord::Migration
  def change
    create_table :core_rewards do |t|
      t.string :handler
      t.string :name
      t.text :description

      t.decimal :cost, precision: 12, scale: 2, default: 0.0, null: false, index: true
      t.decimal :value, precision: 12, scale: 2, default: 0.0, null: false, index: true

      t.json :settings, default: {}, null: false

      t.timestamps null: false
    end
  end
end
