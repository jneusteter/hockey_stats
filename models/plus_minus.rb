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
    puts 'What is the Game id: '
    game_id = gets.chomp

    puts 'List the players(+, p1, 12, 12, 34, 53|-, p2, 12, 12, 32,32)'
    total_pms = gets.chomp

    total_pms.split('|').each do |pms| 
      pms.split(',').each do |pm|
        plus_or_minus = 'pm[0]'
        period = 'pm[1]'
        pm.pop[0]
        pm.pop[1]
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
end
