def plus_minus
  backup_db
  print_plus_minus

  game_id = get_game_id

  # Peroid
  period = get_period

  # Plus or Minus
  puts 'Was it [p]lus or [m]inus?'
  pm = gets.chomp
  case pm
  when 'm'
    pm = -1
  when 'p'
    pm = 1
  end

  # Player ID
  print_players

  puts 'What are the players jersey numbers?[18,10,3,15,12]'
  gets.split(',').each do |player_id|
    plus_minus = PlusMinus.new
    plus_minus.game_id = game_id
    plus_minus.player_id = player_id
    plus_minus.plus_minus = pm
    plus_minus.period = period
    plus_minus.save
  end
end
