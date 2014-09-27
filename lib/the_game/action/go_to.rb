class TheGame
  class Action
    class GoTo < Action
      def initialize(place)
        @place = place
      end

      def description
        "going to #{@place.description}..."
      end

      def perform(person, map, time_in_minutes)
        person.go_to(@place)
      end

      def done?(person)
        person.distance_to(@place) < 2.0
      end
    end
  end
end
