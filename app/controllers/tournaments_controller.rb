class TournamentsController < ApplicationController

    def index
        @tournaments = Tournament.all
    end

    def show
        @tournament = Tournament.find(params[:id])
        @leagues = @tournament.leagues.order(created_at: :desc).paginate(page: params[:leagues_page], per_page: 7)
        @games = @tournament.games.order(created_at: :desc).paginate(page: params[:games_page], per_page: 7)
        @user = current_user
        @game_predictions = @user.game_predictions.where(game: @games) if @user
    end

    def edit
        @tournament = Tournament.find(params[:id])
    end

    def new
        @tournament = Tournament.new()
    end

    def create
        @tournament = Tournament.new(tournament_params)

        if @tournament.save
            redirect_to tournaments_path, notice: "Tournament successfully created!"
        else 
            render :new, status: :unprocessable_entity
        end
    end

    def update
        @tournament = Tournament.find(params[:id])
        
        if @tournament.update(tournament_params)
            redirect_to tournament_path, notice: "Tournament successfully updated!"
          else
            render :edit, status: :unprocessable_entity
        end

    end

    def destroy
        @tournament = Tournament.find(params[:id])

        @tournament.destroy

        redirect_to tournaments_path, alert: "Tournament successfully deleted!"

    end

    private

    def tournament_params
        params.require(:tournament).permit(:name, :start_date, :end_date, :status)
    end
end
