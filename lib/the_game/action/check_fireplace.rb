class TheGame
  class Action
    class CheckFireplace
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

            firewood = settlement.stash.get_firewood
            if firewood
              settlement.add_firewood_to_fire(firewood)
            else
              # don't know what to do yet
              raise Exception
            end
          end

          # expected_firewood_amount = 2 * 24 * 60
          # if stash.firewood_amount < expected_firewood_amount
          #   new_job = Action::LookForTreeToCut.new
          # end

          # person.do_stuff
        else
          person.go_to(fire_tile)
        end
      end
    end
  end
end
