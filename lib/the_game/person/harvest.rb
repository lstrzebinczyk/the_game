class TheGame
  class Person
    class Harvest
      def initialize(tile)
        @tile = tile
        @turns_left = 4
      end

      def description
        x = @tile.x
        y = @tile.y
        "harvesting food at #{x}, #{y}"
      end

      def perform(person, map)
        if @turns_left == 0
          harvested_food = Food.new
          if person.hungry?
            person.action = Eat.new(harvested_food)
          else
            person.inventory << harvested_food
            person.action = CarryFoodToStash.new
          end
        else
          @turns_left -= 1
        end
      end
    end
  end
end
