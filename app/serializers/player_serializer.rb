class PlayerSerializer < ActiveModel::Serializer
  alias :read_attribute_for_serialization :send
  attributes :score, :user_id

  def user_id
    object.id
  end

  def score
    object.total_score
  end
end
