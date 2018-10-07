class Goal < Sequel::Model
  many_to_one :player
  many_to_one :game

  def self.print_all
    Goal.all.each do |goal|
      puts "#{goal[:game_id]} | Scored By => #{goal[:scored_by]} in the #{goal.period} period, A1 #{goal[:assist_one]}, A2 #{goal[:assist_two]}"
    end
  end

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

  def self.add
    system('clear')
    Player.print_all
    puts 'Who scored the goal?'
    player_id = gets.chomp
  
    # Assist One
    puts 'Who got assist one?'
    assist_one = gets.chomp
  
    # Assist two
    puts 'Who got assist two?'
    assist_two = gets.chomp
  
    # Period
    period = get_period
  
    goal = Goal.new
    goal.game_id = game_id
    goal.player_id = player_id
    goal.assist_one = assist_one
    goal.assist_two = assist_two
    goal.period = period
    goal.save
  end

  def self.bulk_add(game_id, data)
    data.split('|').each do |event|
      goal = event.split(',')
      if goal[0] == 'g'
        puts 'goal'
        puts goal.select { |item| item.start_with?('p') }.first.tr('p', '').to_i
        goal_forward = Goal.new
        goal_forward.period = goal.select { |item| item.start_with?('p') }.first.tr('p', '').to_i
        goal_forward.scored_by = goal.select { |item| item.start_with?('g') }.first.tr('g', '').to_i
        goal_forward.assist_one = goal.select { |item| item.start_with?('a') }.first.tr('a', '').to_i
        goal_forward.save
      end
    end
  end
end
