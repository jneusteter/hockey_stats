require 'spec_helper'

RSpec.describe 'HockeyStatsTracker::App::GameHelper' do
  describe '#format_date' do
    let(:helpers) { Class.new }
    before { helpers.extend HockeyStatsTracker::App::GameHelper }
    subject { helpers }

    it 'return clean date' do
      date = DateTime.parse('2017-10-10 19:15:00 -0400')
      formated = 'Oct 10 2017  7:15pm'
      expect(helpers.format_date(date)).to eq(formated)
    end
  end
end
