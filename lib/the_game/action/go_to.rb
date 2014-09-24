class TheGame
  class Action
    class GoTo < Action
      def initialize(place)
        @place = place
      end

      def then(next_job)
        @next_job = next_job
        self
      end

      def type
        @next_job.type
      end

      def description
        "going to #{@place.description}..."
      end

      def perform(person, map, time_in_minutes)
        if person.distance_to(@place) < 2.0
          person.action = @next_job
        else
          person.go_to(@place)
        end
      end
    end
  end
end
