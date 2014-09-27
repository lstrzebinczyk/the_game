class TheGame
  class Action
    class Cook < Action
      def self.create(food_type)
        stash = Settlement.instance.stash
        GoTo.create(stash).then(new(food_type))
      end

      def initialize(food_type)
        @food_type = food_type
        @seconds_left = 20 * 60
        stash = Settlement.instance.stash
        stash.get(@food_type)
      end

      def type
        :cooking
      end

      def description
        "cooking #{@food_type}"
      end

      def perform(person, map, time_in_seconds)
        @seconds_left -= time_in_seconds

        if @seconds_left == 0
          stash = Settlement.instance.stash
          cooked_fish = Item::CookedFish.new
          stash.add(cooked_fish)
          person.do_stuff
        end
      end
    end
  end
end
