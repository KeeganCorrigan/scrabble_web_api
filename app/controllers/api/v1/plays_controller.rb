class Api::V1::PlaysController < ApplicationController
  before_action :set_player, :set_game

  def create
    @game = Game.find(params[:game_id])
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
    if @game
      set_player(@game.player_1_id, @game.player_2_id)
    else
      render json: message: "Invalid game.", status: 400
  end

  def set_player(game)
    if params[:user_id] == @game.player_1_id
      @player = User.find(params[:user_id])
    elsif params[:user_id] == @game.player_2_id
      @player = User.find(params[:user_id])
    else
      render json: message: "Invalid user.", status: 400
  end
end
