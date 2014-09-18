class TheGame
  class Person
    class FetchFood
      def initialize(food_tile)
        @food_tile = food_tile
      end

      def description
        x = @food_tile.x
        y = @food_tile.y
        "fetching food at #{x}, #{y}"
      end

      def perform(person, map)
        if @food_tile.x == person.x and @food_tile.y == person.y
          if @food_tile.has_food?
            @food_tile.clear
            person.action = Eat.new
          else
            person.action = LookForFood.new
          end
        else
          # go to proper tile
          if @food_tile.x < person.x
            person.x -= 1
          elsif @food_tile.x > person.x
            person.x += 1
          end
          if @food_tile.y < person.y
            person.y -= 1
          elsif @food_tile.y > person.y
            person.y += 1
          end
        end
      end
    end
  end
end
