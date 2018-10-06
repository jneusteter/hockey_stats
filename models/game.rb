class Game < Sequel::Model
  many_to_one :team
  one_to_many :goals

  def self.id_by_category(category)
    where(team_id: Team.where(category: category).map(:id)).map(:id)
  end
end
