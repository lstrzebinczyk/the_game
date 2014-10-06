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
        fields = []
        [0, 1, 2, 3].each do |row|
          [0, 1, 2, 3].each do |col|
            tile = map.fetch(dormitory_x + row, dormitory_y + col)
            fields << tile
            tile.building = dormitory
          end
        end

        dormitory.fields = fields

        map.create_building_event(dormitory)

        settlement.dormitory = dormitory
        person.do_stuff
      end
    end
  end
end
