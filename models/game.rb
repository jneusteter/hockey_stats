class Game < Sequel::Model
  many_to_one :team
  one_to_many :goals

  def self.id_by_category(category)
    where(team_id: Team.where(category: category).map(:id)).map(:id)
  end

  def self.print_all
    system('clear')
    rows = []
    all.each do |game|
      rows << [game.id,
               game.type,
               game.home_away,
               game.team.town,
               game.goals.count,
               game.team.category,
               game.datetime_played]
    end
    puts Terminal::Table.new rows: rows
  end

  def self.print(id)
    p Game.where(id: id)
  end

  def self.add
    Game.print_all
    game = Game.new
    puts 'What is the game number? '
    game.id = gets.chomp
    Team.print_all
    puts 'What is the team id? '
    game.team_id = gets.chomp
    puts 'When was the game played[2017/11/3 6:30pm]'
    game.datetime_played = DateTime.parse(gets.chomp)
    puts 'Is the game [h]ome or [a]way? '
    h_a = gets.chomp
    if h_a == 'h'
      game.home_away = 'home'
    elsif h_a == 'a'
      game.home_away = 'away'
    end
    game.type = prompt_type
    game.save
  end

  def self.prompt_type
    puts 'What is the game type, [e]xibition, [r]egular, [p]layoff, [t]ournament?'
    case gets.chomp
    when 'e'
      return 'exibition'
    when 'r'
      return 'regular'
    when 'p'
      return 'playoff'
    when 't'
      return 'tournament'
    end
  end

  def self.add_stats
    system('clear')
    print_all
    puts 'Game to add stats to: '
    game_id = gets.chomp
    puts 'Enter stats: g,p1,g18,a13,3,1,4|ga,p2,12,14,15,16,16'
    data = gets.chomp
    Goal.bulk_add(game_id, data)
    # PlusMinus.bulk_add(game_id, data)
  end
end
