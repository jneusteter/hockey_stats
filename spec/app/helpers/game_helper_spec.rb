require 'spec_helper'

RSpec.describe "HockeyStatsTracker::App::GameHelper" do
  describe '#format_date' do
    let(:helpers){ Class.new }
    before { helpers.extend HockeyStatsTracker::App::GameHelper }
    subject { helpers }

    it "return clean date" do
      expect(format_date("2017-10-06 19:15:00 -0400")).to eq("Oct 10 2017 4:15pm")
    end
  end
end
