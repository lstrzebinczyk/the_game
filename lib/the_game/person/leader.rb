class TheGame
  class Person
    class Leader < Person
      def type
        :leader
      end

      def accepted_jobs
        [:management, :survival, :building, :haul]
      end

      def to_s
        "L"
      end
    end
  end
end
