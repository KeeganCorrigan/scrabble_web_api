class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def set_game
    @game = Game.find(params[:game_id]) || Game.find(params[:id])
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

  def validate_game
    game = Game.where(id: params[:id])

    unless game.length > 0
      render json: { message: "Invalid game" }, status: 400
    end
  end
end
