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

  def self.count_by_category(player_id, category)
    where(player_id: player_id).where(game_id: Game.where(team_id: Team.where(category: category).map(:id)).map(:id)).count
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

  def self.bulk_add(game_id, data)
    data.split('|').each do |event|
      goal = event.split(',')
      next unless goal[0] == 'g'

      goal_forward = Goal.new
      goal_forward.period = goal.detect { |item| item.start_with?('p') }
                                .tr('p', '')
                                .to_i
      goal_forward.player_id = goal.detect { |item| item.start_with?('g') }
                                   .tr('g', '')
                                   .to_i
      goal_forward.assist_one = goal.detect { |item| item.start_with?('a') }
                                    .tr('a', '')
                                    .to_i
      goal_forward.game_id = game_id
      goal_forward.save
    end
  end
end
