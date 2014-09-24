class TheGame
  class Action
    class CheckFirewoodInStash < Action
      def description
        "checking firewood in stash"
      end

      def type
        :management
      end

      def perform(person, map, time_in_minutes)
        settlement = TheGame::Settlement.instance
        stash_tile = settlement.stash_tile
        stash      = settlement.stash

        if person.distance_to(stash_tile) < 2.0
          # we need enough wood for the fireplace to burn for 2 days (2 * 24 * 60 minutes)

          expected_firewood_amount = 2 * 24 * 60
          if stash.firewood_amount < expected_firewood_amount
            new_job = Action::LookForTreeToCut.new
            TheGame::Settlement.instance.add_job(new_job)
          end

          person.do_stuff
        else
          person.go_to(stash_tile)
        end
      end
    end
  end
end
