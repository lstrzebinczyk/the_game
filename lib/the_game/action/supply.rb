class TheGame
  class Action
    class Supply < Action
      class Load < Action
        def initialize(item_type, from: place)
          @item_type = item_type
          @from      = from
        end

        def done?(person)
          true
        end

        def perform(person, map, time_in_minutes)
          while person.can_carry_more?(@item_type) and @from.has?(@item_type)
            item = @from.get(@item_type)
            person.inventory.add(item)
          end
        end
      end

      class Unload < Action
        def initialize(item_type, to: place)
          @item_type = item_type
          @to      = to
        end

        def done?(person)
          true
        end

        def perform(person, map, time_in_minutes)
          while @to.need?(@item_type) and person.has?(@item_type)
            item = person.get(@item_type)
            @to.add(item)
          end
        end
      end

      def self.create(place, with: item_type, from: supplier)
        action = GoTo.create(from)
          .then(Load.create(with, from: from))
          .then(GoTo.create(place))
          .then(Unload.create(with, to: place))
        action.description = "Supplying #{place.description} with #{with} from #{from.description}"
        action
      end
    end
  end
end
