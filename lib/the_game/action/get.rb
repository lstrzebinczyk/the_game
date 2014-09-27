class TheGame
  class Action
    class Get < Action
      def self.create(item_type, opts)
        from = opts[:from]
        GoTo.create(from)
          .then(new(item_type, from: from))
      end

      def initialize(item_type, opts)
        from = opts[:from]
        @item_type  = item_type
        @place      = from
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

      def done?(person)
        @done
      end

      def perform(person, map, time_in_minutes)
        item = @place.get(@item_type)

        if item
          person.inventory.add(item)
          # person.action = @next_action
          @done = true
        else
          person.do_stuff
        end
      end
    end
  end
end
