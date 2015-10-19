require 'rails_helper'

describe 'Games API', :type => :request do

  let(:request_headers) {{
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
  }}

  it 'allows creation of a game' do
    json = {
        game: { name: 'Test' }
    }.to_json

    post '/games', json, request_headers

    expect(response).to be_success
    expect(response.headers['Location']).to_not be_nil
    location = response.headers['Location']
    expect(location).to match(/\/games\/(\d+)$/)
    id_num = /\/games\/(\d+)$/.match(location)[1]

    expect(Game.where(id: id_num)).to exist
    g = Game.find(id_num)
    expect(g.name).to eq('Test')
  end

  it 'fetches details for a specific game along with the frames' do
    game = Game.create(name: 'test')
    Frame.create!(game: game, player_id: 1, number: 1, shot_1: 2, shot_2: 3)
    Frame.create!(game: game, player_id: 2, number: 1, shot_1: 10)

    get "/games/#{game.id}", request_headers

    expect(response).to be_success
    expect(json).to include('id', 'name', 'players')
    expect(json['players']).to respond_to(:length)
    expect(json['players'].length).to eq(2)
    expect(json['players'][0]).to include('player_id', 'score', 'frames')
    expect(json['players'][0]['frames']).to respond_to(:length)
    expect(json['players'][0]['frames'][0]).to include('shot_1', 'shot_2', 'shot_3', 'score', 'number', 'cumulative_score', 'url')
  end

  it 'fetches all games' do
    2.times { Game.create }

    get '/games', request_headers

    expect(response).to be_success
    expect(json).to_not be_nil
    expect(json.length).to eq(2)
    expect(json[0]).to include('id', 'url', 'name')
  end

end
