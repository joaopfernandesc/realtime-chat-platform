require 'rails_helper'

describe ChatChannel, type: :channel do
  context 'when room is not provided' do
    it 'subscribes to a generic stream' do
      subscribe

      expect(subscription).to be_confirmed
      expect(subscription).to have_stream_from("general_chat_channel")
    end
  end

  context 'when room is provided' do
    let(:room) { Faker::Lorem.word }
    
    it 'subscribes to a stream' do
      subscribe(room: room)

      expect(subscription).to be_confirmed
      expect(subscription).to have_stream_from("chat_channel_#{room}")
    end
  end
end
