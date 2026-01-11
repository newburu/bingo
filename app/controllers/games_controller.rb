class GamesController < ApplicationController
  before_action :set_game, only: [ :show, :spin, :reset, :auth ]
  before_action :authenticate_game!, only: [ :spin, :reset ]
  rescue_from ActiveRecord::RecordNotFound, with: :game_not_found

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(password: params[:password])
    @game.history = []
    
    if @game.save
      if params[:password].present?
        session[:game_permissions] ||= {}
        session[:game_permissions][@game.id.to_s] = true
      end
      redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @authenticated = !@game.password_digest? || (session[:game_permissions] && session[:game_permissions][@game.id.to_s])
  end

  def auth
    if @game.authenticate(params[:password])
      session[:game_permissions] ||= {}
      session[:game_permissions][@game.id.to_s] = true
      redirect_to game_path(@game), notice: "認証しました"
    else
      redirect_to game_path(@game), alert: "パスワードが違います"
    end
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

  def authenticate_game!
    return unless @game.password_digest?
    
    unless session[:game_permissions] && session[:game_permissions][@game.id.to_s]
      respond_to do |format|
        format.html { redirect_to game_path(@game), alert: "操作にはパスワードが必要です" }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("controls", partial: "games/password_form", locals: { game: @game, message: "操作にはパスワードが必要です" }) }
      end
    end
  end

  def game_not_found
    render :not_found, status: :not_found
  end
end
