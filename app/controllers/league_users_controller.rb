class LeagueUsersController < ApplicationController

    def new
        @league_user = LeagueUser.new
        @league = League.find(params[:league_id])
    end
    
    def create
        @league = League.find(params[:league_id])
        @user = User.find(params[:user_id])
        @league_user = LeagueUser.new(league: @league, user: @user)
    
        if @league_user.save
          redirect_to @league, notice: 'User added to league successfully!'
        else
          render :new
        end
    end

end
