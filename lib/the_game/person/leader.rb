class TheGame
  class Person
    class Leader < Person
      def type
        :leader
      end

      def accepted_jobs
        [:management, :haul]
      end
    end
  end
end
