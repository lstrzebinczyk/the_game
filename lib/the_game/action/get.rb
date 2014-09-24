class TheGame
  class Action
    class Get < Action
      def self.create(item_type, from: place, then_action: action)
        get_action = new(item_type, from: from)
        get_action.then(then_action)

        GoTo.create(from).then(get_action)
      end

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

      # def perform(person, map, time_in_minutes)
      #   item = @place.get(@item_type)

      #   if item
      #     person.inventory.add(item)
      #     person.action = @next_action
      #   else
      #     # return job to stack if you can't find proper item
      #     Settlement.instance.add_job(self)
      #     person.do_stuff
      #   end
      # end

      def perform(person, map, time_in_minutes)
        item = @place.get(@item_type)

        if item
          person.inventory.add(item)
          person.action = @next_action
        else
          Settlement.instance.add_job(self)
          person.do_stuff
        end
      end
    end
  end
end
