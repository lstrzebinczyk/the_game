class TheGame
  class Action
    class RetrieveAxeToStash
      def description
        "carrying axe to stash..."
      end

      def perform(person, map, time_in_minutes)
        stash_tile = TheGame::Settlement.instance.stash_tile
        stash      = TheGame::Settlement.instance.stash

        if person.close_enough_to(stash_tile)
          axe = person.inventory.get_axe
          stash.add(axe)
          person.do_stuff
        else
          person.go_to(stash_tile)
        end
      end
    end
  end
end
