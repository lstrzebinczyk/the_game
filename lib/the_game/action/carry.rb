class TheGame
  class Action
    class Carry < Action
      def self.create(item_type, to: place)
        GoTo.create(to).then(new(item_type, to: to))
      end

      def initialize(item_type, to: place)
        @item_type  = item_type
        @place      = to
      end

      def description
        "carrying #{@item_type} to #{@place.description}..."
      end

      def type
        :haul
      end

      def perform(person, map, time_in_minutes)
        item = person.inventory.get(@item_type)
        @place.add(item)
        person.do_stuff
      end
    end
  end
end
