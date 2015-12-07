class AddProviderHandler < ActiveRecord::Migration
  def up
    add_column :core_providers, :handler, :string, null: false, default: ''

    Core::Provider.update_all('handler = slug') unless Rails.env.test?
  end

  def down
    remove_column :core_providers, :handler
  end
end
