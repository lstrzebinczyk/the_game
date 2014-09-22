class TheGame
  class Person
    class Harvest
      def initialize(tile)
        @tile = tile
        @turns_left = 2
      end

      def description
        x = @tile.x
        y = @tile.y
        "harvesting food at #{x}, #{y}"
      end

      def perform(person, map)
        if @turns_left == 0
          harvested_food = Food.new
          person.action = Eat.new(harvested_food)
        else
          @turns_left -= 1
        end
      end
    end
  end
end
