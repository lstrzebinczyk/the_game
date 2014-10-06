class TheGame
  class Action
    class WonderForNoReason < Action
      def description
        "just wondering"
      end

      def perform(person, map, time_in_minutes)
        if person.thirsty?
          person.action = Action::LookForSomethingToDrink.create
        elsif person.hungry?
          person.action = Action::LookForFood.create
        elsif person.sleepy?
          person.action = Action::LookForPlaceToSleep.create
        elsif person.has_personal_jobs?
          person.take_personal_job
        elsif person.will_take_jobs
          job = TheGame::Settlement.instance.get_job(person)

          if job
            person.action = job
          else
            person.do_stuff
          end
        end
      end
    end
  end
end
