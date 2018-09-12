class GameSerializer < Activeodel::Serializer
  :game_id, :scores

  def game_id
    object.id
  end

  def scores
    
  end
end
