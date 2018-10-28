class PlusMinus < Sequel::Model
  many_to_one :player
  many_to_one :game

  def self.print_all
    rows = []
    all.each do |plus|
      rows << [plus.id]
    end
    puts Terminal::Table.new rows: rows
  end

  def self.total_by_player(player_id)
    where(player_id: player_id).sum(:plus_minus)
  end

  def self.add
    Game.print_all
    puts 'What is the Game id: '
    game_id = gets.chomp

    puts 'What period(overtime = 4)'
    period = gets.chomp

    puts 'Is it a plus or minus(p or m)'
    plus_minus = gets.chomp

    puts 'List the players(12,12,34,53)'
    players = gets.chomp

    players.split(',').each do |player_id|
      pm = PlusMinus.new
      pm.game_id = game_id
      pm.player_id = player_id
      pm.period = period
      pm.plus_minus = if plus_minus == 'p'
                        1
                      elsif plus_minus == 'm'
                        -1
                      end
      pm.save
    end
  end
end
