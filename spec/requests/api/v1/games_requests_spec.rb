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

    it "returns invalid response if game id does not exist" do

      get "/api/v1/games/891723897"

      expect(response).to_not be_successful
      expect(response).to have_http_status(400)
    end
  end

  context "POST /api/v1/games/1/plays" do
    it "increments total score for the game" do
      josh = User.create(id: 1, name: "Josh")
      sal = User.create(id: 2, name: "Sal")

      game = Game.create(player_1: josh, player_2: sal)

      josh.plays.create(game: game, word: "sal", score: 3)
      josh.plays.create(game: game, word: "zoo", score: 12)
      sal.plays.create(game: game, word: "josh", score: 14)
      sal.plays.create(game: game, word: "no", score: 2)

      json_payload = {user_id: "1", word:"at"}

      post "/api/v1/games/#{game.id}/plays", params: json_payload

      expect(response).to have_http_status(201)

      get "/api/v1/games/#{game.id}"

      game = JSON.parse(response.body, symbolize_names: true)

      expect(game[:scores].first[:score]).to eq(17)
    end

    it "returns invalid response if player id in valid" do
      josh = User.create(id: 1, name: "Josh")
      sal = User.create(id: 2, name: "Sal")

      game = Game.create(player_1: josh, player_2: sal)

      josh.plays.create(game: game, word: "sal", score: 3)
      josh.plays.create(game: game, word: "zoo", score: 12)
      sal.plays.create(game: game, word: "josh", score: 14)
      sal.plays.create(game: game, word: "no", score: 2)

      json_payload = {user_id: "8923", word:"at"}

      post "/api/v1/games/#{game.id}/plays", params: json_payload

      expect(response).to have_http_status(401)
    end

    it "returns Invalid word if a word is invalid" do
      josh = User.create(id: 1, name: "Josh")
      sal = User.create(id: 2, name: "Sal")

      game = Game.create(player_1: josh, player_2: sal)

      josh.plays.create(game: game, word: "sal", score: 3)
      josh.plays.create(game: game, word: "zoo", score: 12)
      sal.plays.create(game: game, word: "josh", score: 14)
      sal.plays.create(game: game, word: "no", score: 2)

      json_payload = {user_id: josh.id, word:"aoiasd01oiadk"}

      post "/api/v1/games/#{game.id}/plays", params: json_payload

      expect(response).to have_http_status(400)
    end
  end
end
