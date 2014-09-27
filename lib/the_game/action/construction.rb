class TheGame
  class Action
    class Construction < Action
      def self.create(building)
        GoTo.create(building).then(new(building))
      end

      def initialize(building)
        @building = building
      end

      def type
        :building
      end

      def description
        "building #{@building.description}"
      end

      def perform(person, map, time_in_seconds)
        @building.seconds_left -= time_in_seconds

        if @building.seconds_left == 0
          @building.status = :done
          person.do_stuff
        end
      end
    end
  end
end
