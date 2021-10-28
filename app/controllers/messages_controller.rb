class MessagesController < ApplicationController
  def index
    render json: Message.order(:id)
  end

  def create
    message = Messages::CreateMessageService.call(message_params)

    render(json: message, status: :created)
  rescue ActiveRecord::RecordInvalid => e
    render(json: { error: e.message }, status: 422)
  end

  private

  def message_params
    params.permit(:sender, :body, :room).to_h
  end
end
