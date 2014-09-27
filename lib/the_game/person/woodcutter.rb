class TheGame
  class Person
    class Woodcutter < Person
      def type
        :woodcutter
      end

      def accepted_jobs
        [:woodcutting, :haul]
      end
    end
  end
end
