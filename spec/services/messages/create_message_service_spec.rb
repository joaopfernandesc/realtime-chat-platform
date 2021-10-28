# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Messages::CreateMessageService) do
  let(:params) { { room: 'room', body: Faker::Lorem.word, sender: Faker::Name.first_name } }

  it 'creates a Message' do
    expect { described_class.call(params) }.to(change { Message.count }.by(1))
  end

  it 'broadcasts the message to a channel' do
    action_cable_server = ActionCable.server
    allow(action_cable_server).to(receive(:broadcast))

    message = described_class.call(params)

    expect(action_cable_server).to(have_received(:broadcast).with('chat_channel_room', message.as_json))
  end

  it 'returns the recently created Message' do
    message = described_class.call(params)

    expect(message).to(eq(Message.last))
  end

  context 'when any of parameters is missing' do
    it 'raises an ActiveRecord::RecordInvalid error' do
      expect { described_class.call({}) }.to(raise_error(ActiveRecord::RecordInvalid))
    end
  end
end