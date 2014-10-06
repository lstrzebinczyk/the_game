class TheGame
  class Action
    class CutLogIntoFirewood < Action
      def self.create
        stash = Settlement.instance.stash
        action = Action::Get.create(:axe, from: stash)
          .then(Action::Get.create(:log, from: stash))
          .then(new)
          .then(Action::Carry.create(:axe, to: stash))
        action.description = "Chopping log into firewood"
        action
      end

      def initialize(tree)
        @minutes_left = 120
      end

      def type
        :woodcutting
      end

      def done?(person)
        @minutes_left == 0
      end

      def perform(person, map, time_in_minutes)
        @minutes_left -= time_in_minutes

        if @minutes_left == 0
          log = person.get(:log)

          stash = Settlement.instance.stash

          log.count(:firewood).times do
            stash.add Item::Firewood.new
          end
        end
      end
    end
  end
end
