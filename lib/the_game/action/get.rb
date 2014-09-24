class TheGame
  class Action
    class Get < Action
      def initialize(item_type, from: place)
        @item_type  = item_type
        @place      = from
      end

      def then(next_action)
        @next_action = next_action
        self
      end

      def description
        x = @place.x
        y = @place.y
        "getting #{@item_type} from #{x}, #{y}..."
      end

      def type
        if @next_action
          @next_action.type
        else
          :haul
        end
      end

      def perform(person, map, time_in_minutes)
        # bini

        if person.distance_to(@place) < 2.0
          # binding.pry

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
