class Api::V1::GamesController < ApplicationController
  before_action :validate_game, :set_game

  def show
    render json: @game, serializer: GameSerializer
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end
end
