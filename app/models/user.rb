class User < ApplicationRecord
  has_many :plays

  def total_score
    plays.map do |play|
      play.score
    end.sum
  end
end
