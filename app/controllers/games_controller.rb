class GamesController < ApplicationController
  before_action :set_game, only: [ :show, :spin, :reset ]
  rescue_from ActiveRecord::RecordNotFound, with: :game_not_found

  def create
    @game = Game.create(history: [])
    redirect_to game_path(@game)
  end

  def show
  end

  def spin
    @game.spin!
    sleep 2.0 unless params[:skip_animation] == "1" # Animation delay

    respond_to do |format|
      format.html { redirect_to game_path(@game) }
      format.turbo_stream
    end
  end

  def reset
    @game.reset!
    redirect_to game_path(@game)
  end

  private

  def set_game
    @game = Game.find_by!(token: params[:token])
  end

  def game_not_found
    render :not_found, status: :not_found
  end
end
