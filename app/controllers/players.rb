HockeyStatsTracker::App.controllers :players do
  get :index do
    @title = 'Players'
    @players = Player.all
    render 'players/index'
  end

  get :show, with: :id do
    @title = 'Player'
    @player = Player[params[:id]]

    @tabs = [{
      name: 'All',
      goal_count: Goal.where(player_id: params[:id]).count,
      assist_count: Goal.where(assist_one: params[:id]).count,
      labels: Game.map(:id),
      goals_per_game: [9, 3, 6, 7],
      assist_per_game: [0, 5, 6],
      plus_minus_per_game: [0, 8, 7]
    }]

    Team.map(:category).map.uniq.each do |c|
      @tabs << {
        name: c,
        goal_count: Goal.count_by_category(params[:id], c),
        assist_count: Goal.assists_by_category(params[:id], c),
        labels: Game.id_by_category(c),
        goals_per_game: Goal.goals_per_game_by_category(params[:id], c),
        assist_per_game: [0, 5, 6],
        plus_minus_per_game: [0, 8, 7]
      }
    end
    render 'players/show'
  end
end
