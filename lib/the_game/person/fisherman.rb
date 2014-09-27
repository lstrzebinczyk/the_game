class TheGame
  class Person
    class Fisherman < Person
      def type
        :fisherman
      end

      def accepted_jobs
        [:cooking, :fisherman, :haul]
      end
    end
  end
end
