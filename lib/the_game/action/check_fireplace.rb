class TheGame
  class Action
    class CheckFireplace < Action
      def description
        "checking fireplace"
      end

      def type
        :survival
      end

      def perform(person, map, time_in_minutes)
        settlement = TheGame::Settlement.instance
        fire_tile  = settlement.fire_tile
        stash_tile = settlement.stash_tile

        if person.distance_to(fire_tile) < 2.0
          if settlement.fire_is_ok?
            person.do_stuff
          else
            # Ignore the fact that person needs to walk between stash and fire for now
            # assume person can throw 1 piece of firewood per minute

            firewood = settlement.stash.get(:firewood)
            if firewood
              settlement.add_firewood_to_fire(firewood)
            else
              # don't know what to do yet
              raise Exception
            end
          end
        else
          person.go_to(fire_tile)
        end
      end
    end
  end
end
