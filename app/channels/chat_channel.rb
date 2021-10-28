# frozen_string_literal: true

class ChatChannel < ApplicationCable::Channel
  GENERAL_CHAT_CHANNEL = 'general_chat_channel'

  def subscribed
    stream_from(channel_name)
  end

  private

  def channel_name
    params[:room].nil? ? GENERAL_CHAT_CHANNEL : "chat_channel_#{params[:room]}"
  end
end
