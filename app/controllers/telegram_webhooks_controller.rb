class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session

  # or just shortcut:
  use_session!

  # You can override global config for this controller.
  # self.session_store = :file_store

  def write!(text = nil, *)
    session[:text] = text
  end

  def read!(*)
    respond_with :message, text: session[:text]
  end

  private

  # In this case session will persist for user only in specific chat.
  # Same user in other chat will have different session.
  def session_key
    "#{bot.username}:#{chat['id']}:#{from['id']}" if chat && from
  end
end