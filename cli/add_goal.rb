def add_goal
  #Backup Database
  backup_db
  print_goals

  game_id = get_game_id

  # Scored By
  print_players
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
