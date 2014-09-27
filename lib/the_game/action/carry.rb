class TheGame
  class Action
    class Carry < Action
      def self.create(item_type, opts)
        to = opts[:to]
        GoTo.create(to).then(new(item_type, to: to))
      end

      def initialize(item_type, opts)
        to = opts[:to]

        @item_type  = item_type
        @place      = to
      end

      def description
        "carrying #{@item_type} to #{@place.description}..."
      end

      def type
        :haul
      end

      def done?(person)
        true
      end

      def perform(person, map, time_in_minutes)
        if @item_type.is_a? Array
          @item_type.each do |type|
            item = person.inventory.get(type)
            @place.add(item)
          end
        else
          item = person.inventory.get(@item_type)
          @place.add(item)
        end
      end
    end
  end
end
