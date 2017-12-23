HockeyStatsTracker::App.controllers :players do
  get :index do
    @title = 'Players'
    @players = Player.all
    render 'players/index'
  end

  get :show, with: :id do
    @title = 'Player'
    @player = Player[params[:id]]
    @list_game_ids = Game.map(:id)
    # @goals_per_game_array =  Goal.where(player_id: params[:id]).group_and_count(:game_id).map(:count)
    # Goals
    @goals_per_game_array = []
    @list_game_ids.each do |game|
      goals = Goal.where(game_id: game).where(player_id: params[:id])
      if goals.nil?
        @goals_per_game_array << 0
      else
        @goals_per_game_array << goals.count
      end
    end
    # PlusMinus
    @plus_minus_per_game_array = []
    @list_game_ids.each do |game|
      plus = PlusMinus.where(game_id: game).where(player_id: params[:id]).sum(:plus_minus)
      if plus.nil?
        @plus_minus_per_game_array << 0
      else
        @plus_minus_per_game_array << plus
      end
    end
    # Assist
    @assist_per_game_array = []
    @list_game_ids.each do |game|
      assist = Goal.where(game_id: game).where(assist_one: params[:id])
      if assist.nil?
        @assist_per_game_array << 0
      else
        @assist_per_game_array << assist.count
      end
    end
    render 'players/show'
  end
end
