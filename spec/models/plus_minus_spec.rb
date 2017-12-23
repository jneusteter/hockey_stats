require 'spec_helper'

RSpec.describe PlusMinus do
  describe "#total_by_player" do
    it "returns 10 when total sum is +10" do
      FactoryBot.create_list(:plus_minus, 10)
      expect(PlusMinus.total_by_player(10)).to eq(10)
    end
    it "returns -10 when total sum is -10" do
      FactoryBot.create_list(:plus_minus, 10, plus_minus: -1)
      expect(PlusMinus.total_by_player(10)).to eq(-10)
    end
  end
end
