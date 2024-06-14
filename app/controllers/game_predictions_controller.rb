class GamePredictionsController < ApplicationController

    def new
        @is_updating = false
        @game = Game.find(params[:game_id])
        @tournament = @game.tournament

        # in the case that the user does not have a prediction
        @game_prediction = GamePrediction.new()

        # lets see if the current user already has a prediction. If they do we should fetch it
        leagues = @tournament.leagues
        leagues.each do |league|
            league_user = LeagueUser.where(user_id: current_user.id, league_id: league.id).first
            
            # lets see if a league user has a prediction
            if (league_user.present?)
                existing_game_prediction = league_user.game_predictions.where(game_id: @game.id).first
                if existing_game_prediction.present?
                    @game_prediction = GamePrediction.new(
                        home_team_goals:  existing_game_prediction.home_team_goals,
                        away_team_goals: existing_game_prediction.away_team_goals,
                        home_team_et_goals:  existing_game_prediction.home_team_et_goals,
                        away_team_et_goals: existing_game_prediction.away_team_et_goals,
                        penalties_winner: existing_game_prediction.penalties_winner 
                    )
                    @is_updating = true
                end
                break
            end
        end
    end

    def create
        puts "COMES IN CREATE"
        # create or update
        @game = Game.find(params[:game_id])
        @tournament = @game.tournament

        leagues = @tournament.leagues
        leagues.each do |league|
            league.league_users.where(user_id: current_user.id).each do |league_user|
                existing_game_prediction = GamePrediction.where(league_user_id: league_user.id, game_id: @game.id).first

                if (existing_game_prediction)
                    # there is an existing prediction, just update it
                    existing_game_prediction.update(game_prediction_params)
                    existing_game_prediction.save

                    redirect_to tournament_game_path(@tournament, @game), notice: "Prediction updated!"
                else
                    game_prediction = GamePrediction.new(game_prediction_params.merge(league_user_id: league_user.id, game_id: @game.id))
                    game_prediction.save

                    redirect_to tournament_game_path(@tournament, @game), notice: "Prediction created!"
                end
            end
        end
    end

    def index

    end
    

    def show

    end

    def destroy

    end

    def update
        puts "COMES IN UPDATE"
    end

    def edit
        puts "COMES IN EDIT"
    end

    private

    def game_prediction_params
        params.require(:game_prediction).permit(:home_team_goals, :away_team_goals, :home_team_et_goals, :away_team_et_goals, :penalties_winner)
    end
end
