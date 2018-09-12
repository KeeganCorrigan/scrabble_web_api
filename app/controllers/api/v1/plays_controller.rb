class Api::V1::PlaysController < ApplicationController
  before_action :set_game

  def create
    @player.plays.create(word: params[:word], game_id: params[:game_id])

    render json: @game, status: 201 
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
    if @game
      set_player(@game)
    else
      render json: { message: "Unauthorized" }, status: 401
    end
  end

  def set_player(game)
    if params[:user_id] == game.player_1_id.to_s
      @player = User.find(params[:user_id].to_s)
    elsif params[:user_id] == game.player_2_id.to_s
      @player = User.find(params[:user_id].to_s)
    else
      render json: { message: "Unauthorized" }, status: 401
    end
  end
end
