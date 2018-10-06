# Helper methods defined here can be accessed in any controller or view in the application

module HockeyStatsTracker
  class App
    module GameHelper
      def format_date(date)
        date.strftime('%b %d %Y %l:%M%P')
      end
    end

    helpers GameHelper
  end
end
