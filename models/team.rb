class Team < Sequel::Model
  one_to_many :games
end
