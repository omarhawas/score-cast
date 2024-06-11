class LeaguesController < ApplicationController
    before_action :set_tournament
    before_action :set_admin_user, only: [:new, :create]

    def index
        @tournament = Tournament.find_by(id: params[:tournament_id])
        @leagues = @tournament.leagues if @tournament && @tournament.leagues.exists?
    end

    def show
        @league = League.find(params[:id])
    end

    def edit
        @league = League.find(params[:id])
    end

    def new
        @league = League.new
    end

    def create
        @league = League.new(league_params)
        @league.admin_user_id = current_user.id
        @league.tournament = Tournament.find(params[:tournament_id])
        @league.winner_user_id = -1

        if @league.save
            redirect_to root_url, notice: "League successfully created!"
        else 
            render :new, status: :unprocessable_entity
        end
    end

    def update
        @league = League.find(params[:id])
        
        if @league.update(league_params)
            redirect_to @league, notice: "League successfully updated!"
          else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @league = League.find(params[:id])

        if @league.destroy
          redirect_to leagues_path, alert: "League successfully deleted!"
        else
          redirect_to @league, alert: "Failed to delete league!"
        end
    end

    private

    def set_tournament
        @tournament = Tournament.find(params[:tournament_id])
    end
    
    def set_admin_user
        redirect_to root_path, alert: 'You need to be logged in to create a league' unless logged_in?
    end

    def league_params
        params.require(:league).permit(:name, :admin_user_id, :winner_user_id, :tournament_id)
    end

end
