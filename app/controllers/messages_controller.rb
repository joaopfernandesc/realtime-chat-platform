class MessagesController < ApplicationController
  def index
    render json: Message.order(:id)
  end

  def create
  end
end
