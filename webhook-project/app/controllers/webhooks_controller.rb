class WebhooksController < ApplicationController
  before_action :authenticate_user!

  def new
    render locals: {
      webhook: Webhook.new(user: current_user)
    }
  end

  def create
    webhook = Webhook.new(webhook_params)
    if webhook.save
      redirect_to dashboard_path
    else
      render "new", locals: {
        webhook: webhook,
      }
    end
  end

  def destroy
    webhook.destroy
    redirect_to dashboard_path

  end

  def status_check
    BackgroundJob::Webhook::StatusCheck.perform_async(webhook.id)
    redirect_to dashboard_path
  end

  private

  def webhook_params
    params.require(:webhook).permit(:user_id, :url)
  end

  def webhook
    Webhook.find_by(params.permit(:id, :webhook_id).transform_keys { |k| k == "webhook_id" ? "id" : k })
  end
end
