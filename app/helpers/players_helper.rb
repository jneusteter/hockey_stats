# Helper methods defined here can be accessed in any controller or view in the application

module HockeyStatsTracker
  class App
    module PlayersHelper
      def total_plus_minus(player_id)
        PlusMinus.total_plus_minus(player_id)
      end
    end

    helpers PlayersHelper
  end
end
