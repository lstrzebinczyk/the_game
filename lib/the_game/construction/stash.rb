class TheGame
  class Construction
    class Stash < Container
      include HasPosition

      def initialize(x, y)
        @x = x
        @y = y
        super()
      end

      def description
        "stash"
      end

      # def get_job(person)
      #   person.accepted_jobs.each do |job_type|
      #     if job_type == :gatherer and need_more_food?
      #       return Action::LookForFoodToHarvest.create()
      #     elsif job_type == :woodcutter and need_more_wood?
      #       return Action::LookForTreeToCut.create()
      #     end
      #   end

      #   # if person.accepted_jobs.include?(:gatherer) and need_more_food?
      #   #   Action::LookForFoodToHarvest.create()
      #   # elsif person.accepted_jobs.include?(:woodcutter) and need_more_wood?

      #   # end
      # end

      private

      def need_more_food?
        food_amount < 3 * Settlement.instance.people_count
      end

      def need_more_wood?
        # we need enough wood for the fireplace to burn for 2 days (2 * 24 * 60 minutes)
        expected_firewood_amount = 2 * 24 * 60
      end
    end
  end
end
