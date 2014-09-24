class TheGame
  class Person
    class Woodcutter < Person
      def type
        :woodcutter
      end

      def accepted_jobs
        [:survival, :woodcutting, :haul]
      end
    end
  end
end
