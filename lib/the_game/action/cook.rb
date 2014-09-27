class TheGame
  class Action
    class Cook < Action
      def self.create(food_type)
        stash = Settlement.instance.stash
        GoTo.create(stash).then(new(food_type))
      end

      def initialize(food_type)
        @food_type = food_type
        @minutes_left = 20
        stash = Settlement.instance.stash
        stash.get(@food_type)
      end

      def type
        :cooking
      end

      def description
        "cooking #{@food_type}"
      end

      def done?(person)
        @minutes_left == 0
      end

      def perform(person, map, time_in_minutes)
        @minutes_left -= time_in_minutes

        if @minutes_left == 0
          stash = Settlement.instance.stash
          cooked_fish = Item::CookedFish.new
          stash.add(cooked_fish)
        end
      end
    end
  end
end
