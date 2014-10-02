class TheGame
  class Action
    class FillWaterskin < Action

      def done?
        false
      end

      def perform(person, map, time_in_minutes)
        waterskin = person.waterskin

        while !waterskin.full?
          waterskin.fill_with(Item::Water.new)
        end

        person.do_stuff
      end
    end
  end
end
