class TheGame
  class Action
    class CheckFirewoodInStash < Action
      def self.create
        settlement = TheGame::Settlement.instance
        stash_tile = settlement.stash_tile

        GoTo.create(stash_tile).then(new)
      end

      def description
        "checking firewood in stash"
      end

      def type
        :management
      end

      def perform(person, map, time_in_minutes)
        stash      = TheGame::Settlement.instance.stash

        # we need enough wood for the fireplace to burn for 2 days (2 * 24 * 60 minutes)
        expected_firewood_amount = 2 * 24 * 60
        if stash.firewood_amount < expected_firewood_amount
          new_job = Action::LookForTreeToCut.create
          # binding.pry
          TheGame::Settlement.instance.add_job(new_job)
        end
        person.do_stuff
      end
    end
  end
end
