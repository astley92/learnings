class AddStatusToWebhooks < ActiveRecord::Migration[7.0]
  def change
    add_column :webhooks, :status, :integer, default: 0, null: false
  end
end
