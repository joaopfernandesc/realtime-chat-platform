require 'rails_helper'

describe 'MessagesController', type: :request do
  describe 'POST /messages' do
    let(:sender) { Faker::Name.name }
    let(:body) { Faker::Lorem.sentence }
    let(:room) { Faker::Lorem.word }
    let(:channel) { "chat_channel_#{room}"}
    
    let(:params) do
      {
        sender: sender,
        body: body,
        room: room
      }
    end
   
    context 'when valid parameters are sent' do
      it 'returns 201 status code' do
        post '/messages', params: params
        expect(response.status).to eq(201)
      end

      it 'returns JSON message in response' do
        post '/messages', params: params
        expected = { id: 1, sender: sender, body: body, room: room }.stringify_keys

        expect(JSON.parse(response.body)).to eq(expected)
      end

      it 'broadcasts message to the correct channel' do
        expected = { id: 1, sender: sender, body: body, room: room }

        expect do
          post '/messages', params: params
        end.to have_broadcasted_to(channel).with(expected)
      end

      it 'persists message is database' do
        post '/messages', params: params
        get '/messages'

        expected = [{ id: 1, sender: sender, body: body, room: room }.stringify_keys]

        expect(JSON.parse(response.body)).to eq(expected)
      end
    end

    context 'when body is not sent' do
      let(:body) { nil }
      include_examples 'does not process message'
    end

    context 'when room is not sent' do
      let(:room) { nil }
      include_examples 'does not process message'
    end

    context 'when sender is not sent' do
      let(:sender) { nil }
      include_examples 'does not process message'
    end
  end
end