class TheGame
  class Action
    class LookForSomethingToDrink < Action
      def description
        "looking for something to drink"
      end

      def perform(person, map, time_in_minutes)
        #currently you can only get drink at river

        closest = map.find_closest_to(person) do |tile|
          tile.content.is_a? Map::Tile::River
        end

        action = Action::GoTo.create(closest).then(Action::DrinkFromRiver.create())
        person.action = action
      end
    end
  end
end
