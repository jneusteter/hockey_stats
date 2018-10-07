HockeyStatsTracker::App.controllers :base do
  get :index, map: '/' do
    @title = 'Players'
    @players = Player.all
    render 'index'
  end
end
