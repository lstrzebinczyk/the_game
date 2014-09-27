class TheGame
  class Action
    class WonderForNoReason < Action
      def description
        "just wondering"
      end

      def perform(person, map, time_in_minutes)
        # move_around(person, map)

        if person.thirsty?
          person.action = Action::LookForSomethingToDrink.create
        elsif person.hungry?
          person.action = Action::LookForFood.create
        elsif person.sleepy?
          person.action = Action::LookForPlaceToSleep.create
        elsif person.will_take_jobs
          job = TheGame::Settlement.instance.get_job(person)

          if job
            person.action = job
          else
            person.do_stuff
          end
        end
      end

      # private

      # def move_around(person, map)
      #   offset_x = rand(3) - 1
      #   offset_y = rand(3) - 1
      #   tile = map.fetch(person.x + offset_x, person.y + offset_y)

      #   while tile.nil? or tile.impassable?
      #     offset_x = rand(3) - 1
      #     offset_y = rand(3) - 1
      #     tile = map.fetch(person.x + offset_x, person.y + offset_y)
      #   end

      #   person.x += offset_x
      #   person.y += offset_y
      # end
    end
  end
end
