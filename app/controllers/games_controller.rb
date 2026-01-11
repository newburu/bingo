class GamesController < ApplicationController
  def index
    @game = Game.current_game
  end

  def spin
    @game = Game.current_game
    @game.spin!
    sleep 2.0 unless params[:skip_animation] == "1" # Animation delay

    respond_to do |format|
      format.html { redirect_to root_path }
      format.turbo_stream
    end
  end

  def reset
    @game = Game.current_game
    @game.reset!
    redirect_to root_path
  end
end
