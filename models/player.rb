class Player < Sequel::Model
  one_to_many :goals
  one_to_many :plus_minus
end
