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
        calculate_points(@game)
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
      params.require(:game).permit(:home_team, :away_team, :game_start, :game_end, :knockout_game, :home_team_goals, :away_team_goals, :home_team_et_goals, :away_team_et_goals, :penalties_winner)
    end

    def calculate_points(game)
      game.game_predictions.each do |game_prediction|
        points_awarded = 0
          # group stage games
          if game.home_team_goals == game_prediction.home_team_goals && game.away_team_goals == game_prediction.away_team_goals
            points_awarded = 3
          else
            actual_score_difference = game.home_team_goals - game.away_team_goals
            predicted_score_difference = game_prediction.home_team_goals - game_prediction.away_team_goals
            if actual_score_difference == predicted_score_difference
              points_awarded = 2
            elsif (actual_score_difference > 0 && predicted_score_difference > 0) || (actual_score_difference < 0 && predicted_score_difference < 0)
              points_awarded = 1
            end
          end
          # knckout games
          if game.knockout_game && game.home_team_et_goals == game_prediction.home_team_et_goals && game.away_team_et_goals == game_prediction.away_team_et_goals
            points_awarded += 1
          end

          # penalties
          if game.knockout_game && game.penalties_winner == game_prediction.penalties_winner
            points_awarded += 1
          end

        game_prediction.update(total_points: points_awarded)
        game_prediction.save
      end
    end
  
  end
