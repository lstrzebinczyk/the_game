class TheGame
  class Action
    class Carry < Action
      def initialize(item_type, to: place)
        @item_type  = item_type
        @place      = to
      end

      def description
        "carrying #{@item_type} to #{@place.type}..."
      end

      def type
        :haul
      end

      def perform(person, map, time_in_minutes)
        if person.close_enough_to(@place)
          item = person.inventory.get(@item_type)
          @place.add(item)

          person.do_stuff
        else
          person.go_to(@place)
        end
      end
    end
  end
end
