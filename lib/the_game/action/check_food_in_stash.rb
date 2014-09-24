class TheGame
  class Action
    class CheckFoodInStash < Action
      def self.create
        settlement = TheGame::Settlement.instance
        stash_tile = settlement.stash_tile

        GoTo.create(stash_tile).then(new)
      end

      def description
        "checking food in stash"
      end

      def type
        :management
      end

      def perform(person, map, time_in_minutes)
        settlement = TheGame::Settlement.instance
        stash      = settlement.stash

        people_count = settlement.people_count
        expected_food_amount = 3 * people_count

        if stash.food_amount < expected_food_amount
          food_collected_per_job = Item::Food.new.alphas

          #because it's easier than taking already planned jobs into account
          settlement.remove_gatherer_jobs!
          new_jobs_count = (expected_food_amount - stash.food_amount) / food_collected_per_job
          new_jobs_count = (new_jobs_count + 1).to_i

          new_jobs_count.times do
            new_job = Action::LookForFoodToHarvest.create
            TheGame::Settlement.instance.add_job(new_job)
          end
        end

        person.do_stuff
      end
    end
  end
end
