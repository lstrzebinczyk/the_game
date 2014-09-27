class TheGame
  class Action
    class CutTree < Action
      def self.create(tree)
        GoTo.create(tree).then(new(tree))
      end

      def initialize(tree)
        @tree = tree
        @minutes_left = 180
      end

      def type
        :woodcutting
      end

      def description
        x = @tree.x
        y = @tree.y
        "cutting tree at #{x}, #{y}"
      end

      def perform(person, map, time_in_minutes)
        @minutes_left -= time_in_minutes

        if @minutes_left == 0
          @tree.cut!
          settlement = Settlement.instance
          person.action = Action::Carry.create(:axe, to: settlement.stash)
        end
      end
    end
  end
end
