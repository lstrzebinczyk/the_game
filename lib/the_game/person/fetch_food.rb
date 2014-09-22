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
        if person.close_enough_to(@food_tile)
          if @food_tile.has_food?
            @food_tile.clear
            person.action = Harvest.new(@food_tile)
          else
            person.action = LookForFood.new
          end
        else
          if @food_tile.has_food?
            # go to proper tile
            person.go_to(@food_tile)
          else
            person.action = LookForFood.new
          end
        end
      end
    end
  end
end
