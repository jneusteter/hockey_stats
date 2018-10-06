class PlusMinus < Sequel::Model
  many_to_one :player
  many_to_one :game

  def self.print_all
    PlusMinus.all.each do |plus|
      puts "#{plus[:game_id]} #{plus[:player_id]} #{plus[:plus_minus]}"
    end
    Player.all.each do |player|
      puts "#{player[:id]} #{player[:last_name]} (#{PlusMinus.where(player_id: player[:id]).sum(:plus_minus)})"
    end
  end

  def self.total_by_player(player_id)
    where(player_id: player_id).sum(:plus_minus)
  end
end
