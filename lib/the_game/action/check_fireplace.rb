class TheGame
  class Action
    class CheckFireplace < Action
      def self.create
        fireplace = TheGame::Settlement.instance.fireplace
        GoTo.create(fireplace).then(new(fireplace))
      end

      def initialize(fireplace)
        @fireplace = fireplace
      end

      def description
        "checking fireplace"
      end

      def type
        :survival
      end

      def perform(person, map, time_in_minutes)
        settlement = TheGame::Settlement.instance

        if @fireplace.fire_is_ok?
          person.do_stuff
        else
          # Ignore the fact that person needs to walk between stash and fire for now
          # assume person can throw 1 piece of firewood per minute

          firewood = settlement.stash.get(:firewood)
          if firewood
            @fireplace.add_firewood_to_fire(firewood)
          else
            # take new job from stack, put this one back in

            person.action = Action::WonderForNoReason.create
            person.action.perform(person, map, time_in_minutes)

            Settlement.instance.add_job(self)
            person.do_stuff

            # # don't know what to do yet
            # raise Exception
          end
        end
      end
    end
  end
end
