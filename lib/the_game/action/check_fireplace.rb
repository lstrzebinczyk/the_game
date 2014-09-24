class TheGame
  class Action
    class CheckFireplace < Action
      def self.create
        fire_tile = TheGame::Settlement.instance.fire_tile
        GoTo.create(fire_tile).then(new)
      end

      def description
        "checking fireplace"
      end

      def type
        :survival
      end

      def perform(person, map, time_in_minutes)
        settlement = TheGame::Settlement.instance

        if settlement.fire_is_ok?
          person.do_stuff
        else
          # Ignore the fact that person needs to walk between stash and fire for now
          # assume person can throw 1 piece of firewood per minute

          firewood = settlement.stash.get(:firewood)
          if firewood
            settlement.add_firewood_to_fire(firewood)
          else
            Settlement.instance.add_job(self)
            person.do_stuff

            # # don't know what to do yet
            # raise Exception
          end
        end
      end
    end
  end
end
