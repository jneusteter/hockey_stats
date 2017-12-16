HockeyStatsTracker::App.controllers :games do
  get :index do
    @title = 'Games'
    @games = Game.all
    render 'games/index'
  end
end
