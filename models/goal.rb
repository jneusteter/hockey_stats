class Goal < Sequel::Model
  many_to_one :player
  many_to_one :game
end
