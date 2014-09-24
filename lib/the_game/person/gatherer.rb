class TheGame
  class Person
    class Gatherer < Person
      def type
        :gatherer
      end

      def accepted_jobs
        [:gatherer, :haul]
      end
    end
  end
end
