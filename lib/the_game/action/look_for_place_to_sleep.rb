class TheGame
  class Action
    class LookForPlaceToSleep < Action
      def description
        "going near fireplace to sleep"
      end

      def perform(person, map, time_in_seconds)
        safe_place_to_sleep = TheGame::Settlement.instance.safe_place_to_sleep
        job = GoTo.create(safe_place_to_sleep).then(Sleep.create(safe_place_to_sleep))
        person.action = job
      end
    end
  end
end
