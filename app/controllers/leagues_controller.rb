class LeaguesController < ApplicationController
    before_action :set_league_and_tournament, only: [:show, :edit, :update, :destroy]
  
    def index
      if params[:tournament_id]
        @tournament = Tournament.find(params[:tournament_id])
        @leagues = @tournament.leagues
      else
        @leagues = League.all
      end
    end
  
    def show
    end
  
    def edit
    end
  
    def new
        @tournament = Tournament.find(params[:tournament_id])
        @league = @tournament.leagues.new
    end
  
    def create
        @tournament = Tournament.find(params[:tournament_id])
      @league = @tournament.leagues.new(league_params)
      @league.admin_user_id = current_user.id
      @league.winner_user_id = -1
  
      if @league.save
        redirect_to root_url, notice: "League successfully created!"
      else
        Rails.logger.debug "Params: #{params.inspect}"
        render :new, status: :unprocessable_entity
      end
    end

    def update
        if @league.update(league_params)
          redirect_to tournament_league_path(@tournament, @league), notice: "League successfully updated!"
        else
          render :edit, status: :unprocessable_entity
        end
    end
      
    def destroy
        Rails.logger.debug "Params: #{params.inspect}"
        @tournament = Tournament.find(params[:tournament_id])
        @league = @tournament.leagues.find(params[:id])
      
        if @league.destroy
          redirect_to tournament_path(@tournament), alert: "League successfully deleted!"
        else
          redirect_to tournament_league_path(@tournament, @league), alert: "Failed to delete league!"
        end
    end
  
    private
  
    def set_league_and_tournament
        Rails.logger.debug "Params: #{params.inspect}"
      if params[:tournament_id]
        @tournament = Tournament.find(params[:tournament_id])
        @league = @tournament.leagues.find(params[:id])
      else
        @league = League.find(params[:id])
        @tournament = @league.tournament
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: "League or Tournament not found!"
    end
  
    def league_params
      params.require(:league).permit(:name, :admin_user_id, :winner_user_id, :tournament_id)
    end
  end
  