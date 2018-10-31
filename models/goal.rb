class Goal < Sequel::Model
  many_to_one :player
  many_to_one :game

  def self.print_all
    rows = []
    all.each do |goal|
      rows << [goal.player.first_name,
               goal.player.last_name,
               goal.assist_one]
    end
    puts Terminal::Table.new rows: rows
  end

  def self.total_by_player(player)
    where(player_id: player).count
  end

  def self.count_by_category(player_id, category)
    if category == 'All'
      where(player_id: player_id).group_and_count(:game_id).all
    else
      where(player_id: player_id)
      .where(game_id: Game.where(team_id: Team.where(category: category)
      .map(:id)).map(:id))
      .count
    end
  end

  def self.assists_by_category(player_id, category)
    where(assist_one: player_id)
    .where(game_id: Game.where(team_id: Team.where(category: category).map(:id))
    .map(:id)).count
  end

  def self.goals_per_game_by_category(player_id, category)
    goals = []
    Game.where(team_id: Team.where(category: category).map(:id)).map(:id).each do |g|
      goals << where(player_id: player_id).where(game_id: g).count
    end
  end

  def self.add
    system('clear')
    
    goal = Goal.new

    Game.print_all
    puts 'What is the game id'
    goal.game_id = gets.chomp

    Player.print_all
    puts 'Who scored the goal?'
    goal.player_id = gets.chomp

    puts 'Who got assist?'
    goal.assist_one = gets.chomp

    puts 'Which period?(Overtime = 4)'
    goal.period = gets.chomp
  
    goal.save
  end
end
