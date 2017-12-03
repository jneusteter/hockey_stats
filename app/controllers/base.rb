HockeyStatsTracker::App.controllers :base do
  get :index, map: '/' do
    render 'index'
  end
end
