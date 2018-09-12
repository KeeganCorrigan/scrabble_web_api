require "rails_helper"

describe 'games API' do
  context 'GET /api/v1/games' do
    it 'returns game information' do
      josh = User.create(id: 1, name: "Josh")
      sal = User.create(id: 2, name: "Sal")

      game = Game.create(player_1: josh, player_2: sal)

      josh.plays.create(game: game, word: "sal", score: 3)
      josh.plays.create(game: game, word: "zoo", score: 12)
      sal.plays.create(game: game, word: "josh", score: 14)
      sal.plays.create(game: game, word: "no", score: 2)

      get "/api/v1/games/#{game.id}"

      game = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(game).to have_key(:game_id)
      expect(game).to have_key(:scores)
      expect(game[:scores].count).to eq(2)
      expect(game[:scores].first).to have_key(:user_id)
      expect(game[:scores].first).to have_key(:score)
    end
  end

  context "POST /api/v1/games/1/plays" do
    it "incrememts total score for the game" do
      josh = User.create(id: 1, name: "Josh")
      sal = User.create(id: 2, name: "Sal")

      game = Game.create(player_1: josh, player_2: sal)

      josh.plays.create(game: game, word: "sal", score: 3)
      josh.plays.create(game: game, word: "zoo", score: 12)
      sal.plays.create(game: game, word: "josh", score: 14)
      sal.plays.create(game: game, word: "no", score: 2)

      json_payload = {user_id: 1, word:"at"}.to_json

      post "/api/v1/games/#{game.id}/plays", params: json_payload

      expect(response).to eq(201)

      get "/api/v1/games/#{game.id}"

      expect(game[:scores].first[:score]).to eq(17)
    end
  end
end
