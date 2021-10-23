shared_examples 'does not process message' do
  it 'returns 422 status code' do
    post '/messages', params: params
    expect(response.status).to eq(422)
  end

  it 'does not broadcast message' do
    expect do
      post '/messages', params: params
    end.not_to have_broadcasted_to(channel)
    expect(response.status).to eq(422)
  end
end
