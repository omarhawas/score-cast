class GamesController < ApplicationController
    before_action :set_tournament
    before_action :set_game, only: [:show, :edit, :update, :destroy]
  
    def index
      @games = @tournament.games
    end
  
    def show
    end
  
    def new
      @tournament = Tournament.find(params[:tournament_id])
      @game = Game.new
    end
  
    def create
      @tournament = Tournament.find(params[:tournament_id])
      @game = @tournament.games.new(game_params)
  
      if @game.save
        redirect_to tournament_game_path(@tournament, @game), notice: "Game successfully created!"
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
      @game = Game.find(params[:id])
    end
  
    def update
      if @game.update(game_params)
        redirect_to tournament_path, notice: "Game successfully updated!"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      if @game.destroy
        redirect_to tournament_games_path(@tournament), notice: "Game successfully deleted!"
      else
        redirect_to tournament_game_path(@tournament, @game), alert: "Failed to delete game!"
      end
    end
  
    private
  
    def set_tournament
      @tournament = Tournament.find(params[:tournament_id]) if params[:tournament_id]
    end
  
    def set_game
      @game = Game.find(params[:id]) 
    end
  
    def game_params
      params.require(:game).permit(:home_team, :away_team, :game_start, :game_end, :knockout_game)
    end
  end