class TheGame
  class Person
    class Woodcutter < Person
      def type
        :woodcutter
      end

      def accepted_jobs
        [:woodcutting, :haul]
      end

      def to_s
        "W"
      end
    end
  end
end
