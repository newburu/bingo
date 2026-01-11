class GamesController < ApplicationController
  def index
    @game = Game.current_game
  end

  def spin
    @game = Game.current_game
    @game.spin!
    redirect_to root_path
  end

  def reset
    @game = Game.current_game
    @game.reset!
    redirect_to root_path
  end
end
