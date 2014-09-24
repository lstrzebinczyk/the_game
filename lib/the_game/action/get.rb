class TheGame
  class Action
    class Get < Action
      def initialize(item_type, from: place)
        @item_type  = item_type
        @place      = from
      end

      def then(next_action)
        @next_action = next_action
      end

      def description
        x = @place.x
        y = @place.y
        "getting #{@item_type} from #{x}, #{y}..."
      end

      def type
        :haul
      end

      def perform(person, map, time_in_minutes)
        if person.distance_to(@place) < 2.0
          item = @place.get(@item_type)
          person.inventory.add(item)
          person.action = @next_action
        else
          person.go_to(@place)
        end
      end
    end
  end
end
