class TheGame
  class Action
    class MoveContent < Action
      class PickUpContent < Action
        def initialize(item_type, opts)
          from = opts[:from]

          @item_type = item_type
          @from      = from
        end

        def done?(person)
          true
        end

        def perform(person, map, time_in_minutes)
          if @from.content.type == @item_type
            content = @from.content
            person.inventory.add(content)
            @from.content = nil
            @from.cleaned! if @from.marked_for_cleaning?
          end
        end
      end

      def self.create(type, opts)
        from = opts[:from]
        to   = opts[:to]

        action = GoTo.create(from)
          .then(PickUpContent.create(:log, from: from))
          .then(Carry.create(type, to: to))
        action.description = "Carrying #{type} to #{to.description}"
        action
      end
    end
  end
end
