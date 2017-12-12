def add_game
  backup_db
  clear
  print_games
  game = Game.new

  # Game Number
  puts 'What is the game number? '
  game.id = gets.chomp

  # Team
  Team.all.each do |team|
    puts "#{team[:id]} => #{team[:town]} #{team[:name]}"
  end
  puts 'What is the team id? '
  game.team_id = gets.chomp

  # Date
  puts 'When was the game played[2017/11/3 6:30pm]'
  game.datetime_played = DateTime.parse(gets.chomp)

  # Home or Away
  puts 'Is the game [h]ome or [a]way? '
  h_a = gets.chomp
  if h_a == 'h'
    game.home_away = 'home'
  elsif h_a == 'a'
    game.home_away = 'away'
  end

  # Game Type
  puts 'What is the game type, [e]xibition, [r]egular, [p]layoff, [t]ournament?'
  case gets.chomp
  when 'e'
    game.type = 'exibition'
  when 'r'
    game.type = 'regular'
  when 'p'
    game.type = 'playoff'
  when 't'
    game.type = 'tournament'
  end

  game.save
  # first_prompt
end
