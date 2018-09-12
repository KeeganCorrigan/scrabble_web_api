require "rails_helper"

describe User do
  describe "instance methods" do
    describe "#total_score" do
      it "returns total score" do
        josh = User.create(id: 1, name: "Josh")
        sal = User.create(id: 2, name: "Sal")

        game = Game.create(player_1: josh, player_2: sal)

        josh.plays.create(game: game, word: "sal", score: 3)
        josh.plays.create(game: game, word: "zoo", score: 12)

        expect(josh.total_score).to eq(15)
      end
    end
  end
end
