require 'spec_helper'

RSpec.describe Goal do
  describe '.count_by_category(player_id, category)' do
    it 'returns 1 when player has 1 goal on c team' do
      FactoryBot.create(:team, category: 'C')
      FactoryBot.create(:player)
      FactoryBot.create(:game)
      FactoryBot.create(:goal)

      expect(Goal.count_by_category(10, 'C')).to eq(1)
    end
  end
end
