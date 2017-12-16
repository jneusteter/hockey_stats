class Game < Sequel::Model
  many_to_one :team
  one_to_many :goals
end
