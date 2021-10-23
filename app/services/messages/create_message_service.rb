# frozen_string_literal: true

module Messages
  class CreateMessageService
    def self.call(params)
      new(params).call
    end

    def initialize(params)
      @message_params = params
    end

    def call
      create_message!
      broadcast

      message
    end

    private

    attr_reader :message_params, :message

    def create_message!
      @message = Message.create!(message_params)
    end

    def broadcast
      ActionCable.server.broadcast("chat_channel_#{message.room}", message.as_json)
    end
  end
end