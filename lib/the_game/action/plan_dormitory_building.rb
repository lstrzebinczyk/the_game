class TheGame
  class Action
    class PlanDormitoryBuilding < Action
      def description
        "planning to build dormitory"
      end

      def type
        :management
      end

      def perform(person, map, time_in_minutes)
        settlement = Settlement.instance
        dormitory_x = settlement.fireplace.x - 5
        dormitory_y = settlement.fireplace.y - 1
        dormitory   = TheGame::Construction::Dormitory.new(dormitory_x, dormitory_y)

        settlement.dormitory = dormitory
        # settlement.firewood_needed += dormitory.firewood_needed

        # dormitory.firewood_needed.times do
        #   # get firewood to dormitory
        #   stash = settlement.stash
        #   job = Action::Get.create(:firewood, from: stash, then_action: Action::Carry.create(:firewood, to: dormitory))

        #   settlement.add_job(job)

        # end

        person.do_stuff
      end
    end
  end
end
