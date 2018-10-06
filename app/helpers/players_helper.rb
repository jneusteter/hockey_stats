# Helper methods defined here can be accessed in any controller or view in the application

module HockeyStatsTracker
  class App
    module PlayersHelper
      def total_assist_one(player_id)
        Goal.where(assist_one: player_id).count
      end

      def total_assist_two(player_id)
        Goal.where(assist_two: player_id).count
      end
    end

    helpers PlayersHelper
  end
end
