class TheGame
  class Action
    class CheckFoodInStash
      def description
        "checking food in stash"
      end

      def type
        :management
      end

      def perform(person, map, time_in_minutes)
        settlement = TheGame::Settlement.instance
        stash_tile = settlement.stash_tile
        stash      = settlement.stash

        if person.distance_to(stash_tile) < 2.0
          # we need days * people
          # since 1 is one bar of food

          people_count = settlement.people_count
          expected_food_amount = 3 * people_count

          if stash.food_amount < expected_food_amount
            food_collected_per_job = Item::Food.new.alphas

            #because it's easier than taking already planned jobs into account
            settlement.remove_gatherer_jobs!
            new_jobs_count = (expected_food_amount - stash.food_amount) / food_collected_per_job
            new_jobs_count = (new_jobs_count + 1).to_i

            new_jobs_count.times do
              new_job = Action::LookForFoodToHarvest.new
              TheGame::Settlement.instance.add_job(new_job)
            end
          end

          person.do_stuff
        else
          person.go_to(stash_tile)
        end
      end
    end
  end
end
