HockeyStatsTracker::App.controllers :players do
  get :index do
    @title = 'Players'
    @players = Player.all
    render 'players/index'
  end

  get :show, with: :id do
    @title = 'Player'
    @player = Player[params[:id]]
    render 'players/show'
  end
end
