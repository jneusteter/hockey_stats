class PlusMinus < Sequel::Model
  many_to_one :player
  many_to_one :game

  def self.print_all
    rows = []
    all.each do |plus|
      rows << [plus.game_id,
               plus.player.first_name,
               plus.player.last_name,
               plus.plus_minus,
               plus.period]
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

    puts 'List the players(+, p1, 10, 10, 10|-, p2, 10, 10, 10)'
    total_pms = gets.chomp

    total_pms.split('|').each do |pms|
      array = pms.split(',')
      period = array[1].tr('p', '').to_i
      if array[0] == '+'
        array.drop(2).each do |player|
          pm = PlusMinus.new
          pm.game_id = game_id
          pm.player_id = player.tr(' ', '').to_i
          pm.plus_minus = 1
          pm.period = period
          pm.save
          print_all
        end
      elsif array[0] == '-'
        array.drop(2).each do |player|
          pm = PlusMinus.new
          pm.game_id = game_id
          pm.player_id = player.tr(' ', '').to_i
          pm.plus_minus = -1
          pm.period = period
          pm.save
          print_all
        end
      else
        puts 'Did not recognize input'
      end
    end
  end
end
