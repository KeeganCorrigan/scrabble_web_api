class GameSerializer < ActiveModel::Serializer
  attributes :game_id, :scores

  def game_id
    object.id
  end

  def scores
    [PlayerSerializer.new(object.player_1), PlayerSerializer.new(object.player_2)]
  end
end
