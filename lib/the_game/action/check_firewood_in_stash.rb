class TheGame
  class Action
    class CheckFirewoodInStash < Action
      def self.create
        settlement = TheGame::Settlement.instance
        stash      = settlement.stash

        GoTo.create(stash).then(new)
      end

      def description
        "checking firewood in stash"
      end

      def type
        :management
      end

      def perform(person, map, time_in_minutes)
        settlement = Settlement.instance
        stash      = settlement.stash

        # we need enough wood for the fireplace to burn for 2 days (2 * 24 * 60 minutes)
        expected_firewood_amount = 2 * 24 * 60

        current_firewood      = stash.firewood_amount
        firewood_lying_around = map.firewood_lying_around


        # decide on cutting new tree if there is not enough firewood
        if stash.firewood_amount + firewood_lying_around < expected_firewood_amount + settlement.firewood_needed
          new_job = Action::LookForTreeToCut.create
          TheGame::Settlement.instance.add_job(new_job)
        end

        person.do_stuff
      end
    end
  end
end
