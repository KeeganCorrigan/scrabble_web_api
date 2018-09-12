class Api::V1::PlaysController < ApplicationController
  before_action :set_game

  def create
    @player.plays.create(word: params[:word], game_id: params[:game_id])

    render json: @game, status: 201
  end  
end
