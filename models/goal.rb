class Goal < Sequel::Model
  many_to_one :player
  many_to_one :game

  def self.count_by_category(player_id, category)
    where(player_id: player_id).where(game_id: Game.where(team_id: Team.where(category: category).map(:id)).map(:id)).count
  end

  def self.assists_by_category(player_id, category)
    where(assist_one: player_id).where(game_id: Game.where(team_id: Team.where(category: category).map(:id)).map(:id)).count
  end

  def self.goals_per_game_by_category(player_id, category)
    goals = []
    Game.where(team_id: Team.where(category: category).map(:id)).map(:id).each do |g|
      goals << where(player_id: player_id).where(game_id: g).count
    end
  end
end
