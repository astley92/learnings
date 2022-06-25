class BackgroundJob::Webhook::StatusCheck
  include Sidekiq::Job

  def perform(webhook_id)
    webhook = Webhook.find(webhook_id)
    webhook.update!(status: "unknown")
    webhook.broadcast_update
    sleep 1
    webhook.update!(status: "checking")
    webhook.broadcast_update
    sleep 1
    webhook.update!(status: "active")
    webhook.broadcast_update
  end
end
