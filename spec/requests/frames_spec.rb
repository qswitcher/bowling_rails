require 'rails_helper'

describe 'Frames API', :type => :request do

  let(:game) { Game.create }
  let(:frame) { Frame.create(game: game, player_id: 1, number: 1, shot_1: 2, shot_2: 3, shot_3: 4)}
  let(:request_headers) {{
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
  }}

  it 'allows creation of a frame for a player' do
    json = {
        frame:{
            game_id: game.id,
            player_id: 1,
            number: 3,
            shot_1: 2,
            shot_2: 3,
            shot_3: 4
        }
    }.to_json

    post '/frames', json, request_headers

    expect(response).to be_success
    expect(response.headers['Location']).to_not be_nil
    location = response.headers['Location']
    expect(location).to match(/\/frames\/(\d+)$/)
    id_num = /\/frames\/(\d+)$/.match(location)[1]

    frame = Frame.find(id_num)
    expect(frame.player_id).to eq(1)
    expect(frame.game_id).to eq(game.id)
    expect(frame.number).to eq(3)
    expect(frame.shot_1).to eq(2)
    expect(frame.shot_2).to eq(3)
    expect(frame.shot_3).to eq(4)
  end

  it 'allows updates of a frame for a player' do
    payload = {
        frame:{
            game_id: game.id,
            player_id: 1,
            number: 3,
            shot_1: 5,
            shot_2: 1,
            shot_3: 2
        }
    }.to_json

    put "/frames/#{frame.id}", payload, request_headers

    expect(response).to be_success
    expect(json).to include('game_id' => game.id,
                            'player_id' => 1,
                            'number' => 3,
                            'shot_1' => 5,
                            'shot_2' => 1,
                            'shot_3' => 2)
  end

  it 'fetches details for a specific frame' do
    get "/frames/#{frame.id}", request_headers

    expect(response).to be_success
    expect(json).to include('game_id' => game.id,
                                     'player_id' => 1,
                                     'number' => 1,
                                     'shot_1' => 2,
                                     'shot_2' => 3,
                                     'shot_3' => 4)
  end

  it 'fetches all frames' do
    Frame.create!(game: game, player_id: 1, number: 2, shot_1: 2, shot_2: 3, shot_3: 4)

    get '/frames', request_headers

    expect(response).to be_success
    puts json

  end

  it 'allows deletion of frames' do
    frame = Frame.create(game: game, number: 1, player_id: 93)

    expect(Frame.where(id: frame.id)).to exist

    delete "/frames/#{frame.id}", request_headers

    expect(response).to be_success
    expect(Frame.where(id: frame.id)).to_not exist
  end
end
