class TheGame
  class Person
    class Harvest
      def initialize(tile)
        @tile = tile
        @minutes_left = 60
      end

      def description
        x = @tile.x
        y = @tile.y
        "harvesting food at #{x}, #{y}"
      end

      def perform(person, map, time_in_minutes)
        if @minutes_left == 0
          harvested_food = Food.new
          if person.hungry?
            person.action = Eat.new(harvested_food)
          else
            person.inventory << harvested_food
            person.action = CarryFoodToStash.new
          end
        else
          @minutes_left -= time_in_minutes
        end
      end
    end
  end
end
