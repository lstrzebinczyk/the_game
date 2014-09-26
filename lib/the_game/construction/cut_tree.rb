      # class CutTree < Content
      #   attr_reader :firewood_left

      #   def initialize
      #     # one cut tree is enough to fire a fireplace for week
      #     @firewood_left = 24 * 7
      #   end

      #   def get(type)
      #     if type == :firewood
      #       @firewood_left -= 1
      #       TheGame::Item::Firewood.new
      #     end
      #   end

      #   def any_firewood_left?
      #     @firewood_left > 0
      #   end

      #   def description
      #     "cut tree"
      #   end

      #   def to_s
      #     "/"
      #   end

      #   def color
      #     :green
      #   end
      # end

class TheGame
  class Construction
    class FallenTree
      include HasPosition

      attr_reader :firewood_left

      def initialize(x, y)
        @x = x
        @y = y

        # one cut tree is enough to fire a fireplace for week
        @firewood_left = 24 * 7
      end

      def get(type)
        # binding.pry
        if type == :firewood
          @firewood_left -= 1
          TheGame::Item::Firewood.new
        end
      end

      def empty?
        @firewood_left == 0
      end

      def description
        "cut tree"
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

      # private

      # def need_more_food?
      #   food_amount < 3 * Settlement.instance.people_count
      # end
    end
  end
end
