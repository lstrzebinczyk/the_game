class TheGame
  class Action
    class Chain
      attr_reader :actions

      def initialize(action)
        @actions = [action]
      end

      def then(next_action)
        if next_action.is_a? Chain
          next_action.actions.each do |action|
            @actions << action
          end
        else
          @actions << next_action
        end
        self
      end

      def perform(person, map, time_in_minutes)
        action = @actions.first
        action.perform(person, map, time_in_minutes)

        if action.done?(person)
          @actions.shift
          if @actions.empty?
            person.do_stuff
          end
        end
      end

      def description=(description)
        @description = description
      end

      def description
        @description || @actions.first.description
      end

      def done?(person)
        raise "#done? called on action chain"
      end
    end

    def self.create(*params)
      new(*params)
    end

    private_class_method :new

    def then(action)
      Chain.new(self).then(action)
    end

    def done?(person = nil)
      raise "#{self.class}#done? not implemented"
    end
  end
end
