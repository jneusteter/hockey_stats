class PlusMinus < Sequel::Model
  many_to_one :player
  many_to_one :game

  def self.total_by_player(player_id)
    where(player_id: player_id).sum(:plus_minus)
  end
end
